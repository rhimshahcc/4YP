% A function to predict the nonzero values in D_test using the naive bayes method
% and then measure the error (RMSE).

function rmse_nb = naive_bayes(D_training,D_test)

[i,j,v] = find(D_test);
nonzero_D_test = [i j v]; % matrix containing all the nonzero values and their position

pred_test = zeros(size(D_test,1),size(D_test,2)); % blank matrix to hold predicted D_test

%user_false_entries = 0; % initialise the user-based false entries counter
%item_false_entries = 0; % initialise the item-based false entries counter

for n = 1:nnz(D_test) % iterate through each nonzero value in D_test
    
    completion = n./nnz(D_test) * 100 % percentage completion of the algorithm

    % The nonzero value's position in the matrix
    row_pos = nonzero_D_test(n,1);
    col_pos = nonzero_D_test(n,2);
    
    item_vect_prob = []; % holds the probabilities for an entry, item-based
    user_vect_prob = []; % holds the probabilities for an entry, user-based
    
    poss_ratings = unique(D_training); % find all the unique ratings in the dataset 
    
    % item-based
    for n_item_val = poss_ratings(1,2):poss_ratings(1,end) % iterate through the possible rating values 
        
        % first part of the prob equation, the prior 
        item_prior = calc_item_prior(col_pos,D_training,n_item_val);
        
        % second part of the prob equation, the likelihood
        item_likelihood = calc_item_likelihood(row_pos,col_pos,D_training,n_item_val);
        
        % multiply the first and second part together 
        nb_item_prob = item_prior .* item_likelihood;
        
        % grow item_vect_prob by each value
        item_vect_prob = [ item_vect_prob ; n_item_val nb_item_prob];
        
    end
    
    % user-based
    %for n_user_val = % iterate through the possible rating values values
        
        % first part of the prob equation
        
        % second part of the prob equation
        
        % multiply the first and second part together 
        
        % grow user_vect_pred by each value
        user_vect_prob = [ user_vect_prob ; n_user_val nb_user_value];
        
    %end
    
    % find the maximum value from vect_pred, asssign to pred_entry
    item_pred_entry = max(item_vect_prob);
    user_pred_entry = item_pred_entry; %max(user_vect_prob);
    
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
rmse_nb = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );  

end 
