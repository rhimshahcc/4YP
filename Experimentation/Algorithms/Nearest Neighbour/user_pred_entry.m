
% A function that predicts the target entry based on the user correlation
% matrix, i.e. user-based NN.

function user_pred_entry = user_pred_entry(user_corr_matrix,col_pos)

matrix_pred = [];

for n_pred = 1:size(user_corr_matrix,1)
    
    row_pred = user_corr_matrix(n_pred,1);
    
    matrix_val_corr = D_training(row_pred,col_pos) * user_corr_matrix(n_pred,2);
    matrix_corr = user_corr_matrix(n_pred,2);
    
    matrix_pred = [ matrix_pred ; matrix_val_corr matrix_corr ];
    
end

sum_matrix_pred = sum(matrix_pred);

sum_val_corr = sum_matrix_pred(1,1);
sum_corr = sum_matrix_pred(1,2);

user_pred_entry = sum_val_corr ./ sum_corr;

end
