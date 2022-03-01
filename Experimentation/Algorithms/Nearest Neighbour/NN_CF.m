
function NN_CF(D_training,D_test)

[i,j,v] = find(D_test);
nonzero_D_test = [i j v];


for n = 1:nnz(D_test)
    
    row_pos = nonzero_D_test(n,1);
    col_pos = nonzero_D_test(n,2);
    
    user_based_sim(row_pos,col_pos,D_training);
    
end

%RMSE: 
%pred_test vs. D_test

end 

% iterate through all the nonzero values (for loop), use find(D_test) 

user_based_sim (i,j) %i,j is the position of the nonzero value being predicted 
find all the users who have also rated the value
Compare user rows to find the similarity 
Select the top-k similar users
Predit the value using the prediction function, and add it to a blank matrix

% --> compare to D_test --> average the error

item_based_sim (i,j) %i,j is the position of the nonzero value being predicted 
% combine the simalarities in an equally weighted function, per 




