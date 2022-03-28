% A function to calculate the implicit ratings matrix, F.

function F = calc_F(s_D_training,D_training)
        
for n_F_one = 1:size(s_D_training,1) % iterate on the error values that haven't met the convergence criterion
        
    row_pos = s_D_training(n_F_one,1); % row position
    col_pos = s_D_training(n_F_one,2); % col position

    D_training(row_pos,col_pos) = 1;
        
end

for n_F_row = 1:size(D_training,1)
    
    % divide each row value by 1 / sqrrt(no. of nnz row values)
    
end 

F = D_training; 

end 
