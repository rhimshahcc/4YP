% A function to calculate pred_test.

function pred_test = form_pred_test(D_test,U,V)

% form pred_test by selecting all the values from D_test
[i,j,v] = find(D_test);
nonzero_D_test = [i j v]; % matrix containing all the nonzero values and their position, [row col value]

R_pred = U*V.'; % predicted value of R

pred_test = zeros(size(D_test)); % initialise an empty pred_test matrix

for n_pred = 1:size(nonzero_D_test,1)
    
    row_pos = nonzero_D_test(n_pred,1); % 
    col_pos = nonzero_D_test(n_pred,2);
    
    pred_test(row_pos,col_pos) = R_pred(row_pos,col_pos); % assign predicted values to pred_test
    pred = R_pred(row_pos,col_pos)
    acc = D_test(row_pos,col_pos)
    
end

end 
