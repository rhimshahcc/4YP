% A function to predict the nonzero values in D_test using the naive bayes method
% and then measure the error (RMSE).

function [rmse_nb,pred_test] = naive_bayes(D_training,D_test,alpha)

[i,j,v] = find(D_test);
nonzero_D_test = [i j v]; % matrix containing all the nonzero values and their position

pred_test = zeros(size(D_test,1),size(D_test,2)); % blank matrix to hold predicted D_test

false_entries = 0;

for n = 1:nnz(D_test) % iterate through each nonzero value in D_test
    
    completion = n./nnz(D_test) * 100 % percentage completion of the algorithm

    % The nonzero value's position in the matrix
    row_pos = nonzero_D_test(n,1);
    col_pos = nonzero_D_test(n,2);

    poss_ratings = unique(D_training); % find all the unique ratings in the dataset 
    item_vect_prob = []; % holds the probabilities for an entry, item-based
    
    % item-based
    for n_item_val = 1:size(poss_ratings,1)-1 % iterate through the possible rating values 
        
        n_item_rating = poss_ratings(n_item_val+1,1); % extract the rating from poss_ratings
        
        % first part of the prob equation, the prior 
        item_prior = calc_item_prior(col_pos,D_training,n_item_rating);
        
        % second part of the prob equation, the likelihood
        item_likelihood = calc_item_likelihood(row_pos,col_pos,D_training,n_item_rating,alpha);
        
        % multiply the first and second part together 
        nb_item_prob = item_prior .* item_likelihood;
        
        % grow item_vect_prob by each value
        item_vect_prob = [ item_vect_prob ; n_item_rating nb_item_prob ];
        
    end
    
    % Find the maximum value from item_vect_pred, asssign to pred_entry
    [~, r] = max(item_vect_prob(:,2));
    pred_entry = item_vect_prob(r,1);
    acc_entry = D_test(row_pos,col_pos); % check the actual entry for testing reasons
    
    % Add the value to a blank matrix: pred_test, if it is a real number
    is_nan = isnan(pred_entry);
    is_inf = isinf(pred_entry);
    
    if (is_nan == 0) && (is_inf == 0)
        
        pred_test(row_pos,col_pos) = pred_entry; % update pred_test
        
    else
        
        false_entries = false_entries + 1; % increase false entries counter by 1
        
        pred_entry = 0; % assign the entry as zero
        D_test(row_pos,col_pos) = 0; % remove the entry from D_test
        
        pred_test(row_pos,col_pos) = pred_entry; % update pred_test
    
    end
    
end

false_entries

% RMSE
rmse_nb = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );  

end 
