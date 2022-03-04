% A function to predict the nonzero values in D_test using the K-NN method
% and then measure the error (RMSE).

function rmse_nn = nearest_neighbour(D_training,D_test,k)

[i,j,v] = find(D_test);
nonzero_D_test = [i j v];

pred_test = zeros(size(D_test,1),size(D_test,2)); % blank matrix to hold predicted D_test

user_false_entries = 0; % initialise the user-based false entries counter
item_false_entries = 0; % initialise the item-based false entries counter

for n = 1:nnz(D_test) % iterate through each nonzero value in D_test
    
    completion = n./nnz(D_test) * 100

    % The nonzero value's position in the matrix
    row_pos = nonzero_D_test(n,1);
    col_pos = nonzero_D_test(n,2);
    
    % Calculate the similarity between the row and all other rows
    user_corr_matrix = user_based_sim(row_pos,col_pos,D_training);
    
    % Calculate the similarity between the column and all other columns
    item_corr_matrix = item_based_sim(row_pos,col_pos,D_training);
    
    % Predict the target entry, using the most similar rows
    top_k_user_corr_matrix = select_top_k(user_corr_matrix,k); % select the top-k similar rows
    [user_pred_entry,user_false_entries] = user_pred(top_k_user_corr_matrix,col_pos,D_training,user_false_entries);
        
    % Predict the target entry, using the most similar col
    top_k_item_corr_matrix = select_top_k(item_corr_matrix,k); % select the top-k similar col
    [item_pred_entry,item_false_entries] = item_pred(top_k_item_corr_matrix,row_pos,D_training,item_false_entries);
    
    % Average item & user predictions to remove bias  
    pred_entry = (user_pred_entry + item_pred_entry)./2;
    acc_entry = D_test(row_pos,col_pos);
    
    % Add the value to a blank matrix: pred_test, if it is a real number
    is_nan = isnan(pred_entry);
    is_inf = isinf(pred_entry);
    
    if (is_nan == 0) && (is_inf == 0)
        
        pred_test(row_pos,col_pos) = pred_entry;
    
    end
    
end

% RMSE
rmse_nn = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );  

end 
