% A function to predict the nonzero values in D_test using the K-NN method
% and then measure the error (RMSE).

function [rmse_nn,pred_test] = nearest_neighbour(D_training,D_test,k)

[i,j,v] = find(D_test);
nonzero_D_test = [i j v];

pred_test = zeros(size(D_test,1),size(D_test,2)); % blank matrix to hold predicted D_test

user_false_entries = 0; % initialise the user-based false entries counter
item_false_entries = 0; % initialise the item-based false entries counter
mutual_false_entries = 0; % initialise the mutual false entries counter, i.e. ones that cannot be predicted at all

D_test_size = nnz(D_test); % initilise size of D_test 

for n = 1:nnz(D_test) % iterate through each nonzero value in D_test
    
    completion = n./D_test_size * 100;

    % The nonzero value's position in the matrix
    row_pos = nonzero_D_test(n,1);
    col_pos = nonzero_D_test(n,2);
    
    % Calculate the similarity between the row and all other rows
    user_corr_matrix = user_based_sim(row_pos,col_pos,D_training);
    
    % Calculate the similarity between the column and all other columns
    item_corr_matrix = item_based_sim(row_pos,col_pos,D_training);
    
    % Predict the target entry, using the most similar rows
    top_k_user_corr_matrix = select_top_k(user_corr_matrix,k); % select the top-k similar rows
    [user_pred_entry] = user_pred(top_k_user_corr_matrix,col_pos,D_training);
    
    if user_pred_entry == 0
        user_false_entries = user_false_entries + 1;
    end
        
    % Predict the target entry, using the most similar col
    top_k_item_corr_matrix = select_top_k(item_corr_matrix,k); % select the top-k similar col
    [item_pred_entry] = item_pred(top_k_item_corr_matrix,row_pos,D_training);
    
    if item_pred_entry == 0
        item_false_entries = item_false_entries + 1;
    end
    
    % Average item & user predictions to remove bias  
    if user_pred_entry ~= 0 && item_pred_entry ~= 0 && isfinite(user_pred_entry) && isfinite(item_pred_entry)
        
        pred_entry = (user_pred_entry + item_pred_entry)./2; % average item & user predictions 
        
    elseif item_pred_entry ~= 0 && isfinite(item_pred_entry) && (user_pred_entry == 0 || isinf(user_pred_entry))
        
        pred_entry = item_pred_entry; % pred_entry is the item entry if the user entry is false
        
    elseif user_pred_entry ~= 0 && isfinite(user_pred_entry) && (item_pred_entry == 0 || isinf(item_pred_entry))
        
        pred_entry = user_pred_entry; % pred_entry is the user entry if the item entry is false
        
    else
        
        pred_entry = 0; % if both user entry and item entry are false, pred_entry = 0
        %pred_entry = sum(D_training(row_pos,:))./nnz(D_training(row_pos,:));  % take an average of all the user entries 
        D_test(row_pos,col_pos) = 0; % remove entry from D_test so that it doesn't affect the RMSE
        mutual_false_entries = mutual_false_entries + 1; % mutual false entries counter
        
    end
    
    %pred_entry
    %acc_entry = D_test(row_pos,col_pos)
   
    pred_test(row_pos,col_pos) = pred_entry;

end

no_false_entries = [nnz(D_test)+mutual_false_entries user_false_entries item_false_entries mutual_false_entries]; % no. of [entries_to_predict user item both]

% RMSE
rmse_nn = sqrt( sum(((D_test - pred_test).^2) ./ nnz(pred_test), 'all') );  

end 
