% A function that predicts the target entry based on the user correlation
% matrix, i.e. user-based NN.

function user_pred_entry = user_pred_entry(user_corr_matrix,col_pos)

matrix_pred = []; % initialise a blank matrix to hold the values for the prediction function

for n_pred = 1:size(user_corr_matrix,1) % iterate through all the user correlation values
    
    row_pred = user_corr_matrix(n_pred,1); % assign the row number for the correlation value to row_pred
    
    matrix_num = D_training(row_pred,col_pos) * user_corr_matrix(n_pred,2); % calculate the numerator
    matrix_den = user_corr_matrix(n_pred,2); % calculatge the denominator
    
    matrix_pred = [ matrix_pred ; matrix_num matrix_den ]; % assign to a matrix all the num. and den. values
    
end

sum_matrix_pred = sum(matrix_pred); % sum the num. and den. values

sum_num = sum_matrix_pred(1,1); % the num. value
sum_den = sum_matrix_pred(1,2); % the den. value

user_pred_entry = sum_num ./ sum_den; % divide the num. and the den. value to get the predicted entry

end
