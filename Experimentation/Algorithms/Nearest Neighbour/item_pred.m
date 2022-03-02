% A function that predicts the target entry based on the item correlation
% matrix, i.e. item-based NN.

function [item_pred_entry,item_false_entries] = item_pred(item_corr_matrix,row_pos,D_training,item_false_entries)

matrix_pred = []; % initialise a blank matrix to hold the values for the prediction function

for n_pred = 1:size(item_corr_matrix,1) % iterate through all the user correlation values
    
    col_pred = item_corr_matrix(n_pred,1); % assign the col number for the correlation value to col_pred
    
    matrix_num = D_training(row_pos,col_pred) * item_corr_matrix(n_pred,2); % calculate the numerator
    matrix_den = item_corr_matrix(n_pred,2); % calculatge the denominator
    
    matrix_pred = [ matrix_pred ; matrix_num matrix_den ]; % assign to a matrix all the num. and den. values
    
end

% Check that the entry can be predicted i.e. check it contains correlation terms
if size(matrix_pred,1) ~= 0
    
    sum_matrix_pred = sum(matrix_pred,1); % sum the num. and den. values

    sum_num = sum_matrix_pred(1,1); % the num. value
    sum_den = sum_matrix_pred(1,2); % the den. value

    item_pred_entry = sum_num ./ sum_den; % divide the num. and the den. value to get the predicted entry
    
    item_false_entries = item_false_entries; % no false entries dedicted i.e. the entry can be predicted
    
elseif size(matrix_pred,1) == 0
    
    item_pred_entry = 0; % entry remains at 0
    item_false_entries = item_false_entries + 1; % increase false entries counter by 1
    
end

end
