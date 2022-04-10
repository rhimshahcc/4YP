% A function that predicts the target entry based on the item correlation
% matrix, i.e. item-based NN.

function [item_pred_entry] = item_pred(item_corr_matrix,row_pos,D_training)

matrix_pred = []; % initialise a blank matrix to hold the values for the prediction function

if size(item_corr_matrix,1) > 0 % check it's possible to predict the entry
    
    for n_pred = 1:size(item_corr_matrix,1) % iterate through all the user correlation values
    
        col_pred = item_corr_matrix(n_pred,1); % assign the col number for the correlation value to col_pred

        matrix_num = D_training(row_pos,col_pred) * item_corr_matrix(n_pred,2); % calculate the numerator
        matrix_den = item_corr_matrix(n_pred,2); % calculatge the denominator

        matrix_pred = [ matrix_pred ; matrix_num matrix_den ]; % assign to a matrix all the num. and den. values
    
    end
    
    % some of the numerators/denominators are = 0, these are false entries
    if nnz(matrix_pred) > 0
        
        sum_matrix_pred = sum(matrix_pred,1); % sum the num. and den. values

        sum_num = sum_matrix_pred(1,1); % the num. value
        sum_den = sum_matrix_pred(1,2); % the den. value

        item_pred_entry = sum_num ./ sum_den; % divide the num. and the den. value to get the predicted entry
    
    else 
        
        item_pred_entry = 0; % entry remains at 0
        
    end
    
else 
    
    item_pred_entry = 0; % entry remains at 0
    
end

end
