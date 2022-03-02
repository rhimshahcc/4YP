
function rmse_nn = nearest_neighbour(D_training,D_test)

[i,j,v] = find(D_test);
nonzero_D_test = [i j v];

pred_test = zeros(size(D_test,1),size(D_test,2)) % blank matrix to hold predicted D_test

for n = 1:nnz(D_test) % iterate through each nonzero value in D_test
    
    % The nonzero value's position in the matrix
    row_pos = nonzero_D_test(n,1);
    col_pos = nonzero_D_test(n,2);
    
    % Calculate the similarity between the row and all other rows
    user_corr_matrix = user_based_sim(row_pos,col_pos,D_training);
    
    % Calculate the similarity between the column and all other columns
    item_corr_matrix = item_based_sim(row_pos,col_pos,D_training);
    
    % Predict the target entry, using the most similar rows
    user_pred_entry = user_pred_entry(user_corr_matrix,col_pos);
    
    % Predict the target entry, using the most similar col
    item_pred_entry = item_pred_entry(item_corr_matrix,row_pos);
    
    % Average item & user predictions to remove bias  
    pred_entry = (user_pred_entry + item_pred_entry)./2;
    
    % Add the value to a blank matrix: pred_test
    pred_test(row_pos,col_pos) = pred_entry;
    
end

%RMSE: 
%pred_test vs. D_test
%rmse_nn

end 
