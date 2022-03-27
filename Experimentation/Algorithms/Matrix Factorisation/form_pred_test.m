% A function to calculate pred_test.

function pred_test = form_pred_test(D_test,U,V)

% form pred_test by selecting all the values from D_test
[i,j,v] = find(D_test);
nonzero_D_test = [i j v]; % matrix containing all the nonzero values and their position, [row col value]

R_pred = U*V.'; % predicted value of R

pred_test_it = zeros(size(D_test)); % initialise an empty pred_test matrix

for n_pred = 1:size(nonzero_D_test,1) % iterate
    
    row_pos = nonzero_D_test(n_pred,1); % row position of the value from D_test
    col_pos = nonzero_D_test(n_pred,2); % col position of the value from D_test
    
    pred_test_it(row_pos,col_pos) = R_pred(row_pos,col_pos); % extract the value from R_pred and assign to pred_test
   
    pred = R_pred(row_pos,col_pos); % predicted entry
    acc = D_test(row_pos,col_pos); % actual entry
    
end

pred_test = pred_test_it;

end 
