% A function to calculate the implicit ratings matrix, F.

function F = calc_F(s_D_training,D_training)
 
% Replace each rated value with a 1
for n_F_one = 1:size(s_D_training,1) % iterate on the number of nonzero values
        
    row_pos = s_D_training(n_F_one,1); % row position
    col_pos = s_D_training(n_F_one,2); % col position

    D_training(row_pos,col_pos) = 1; % replace each nonzero value with a 1
        
end

% Divide each row by the square root of the number of nonzero values (i.e. 1s)
for n_F_row = 1:size(D_training,1) % iterate on the number of rows of D_training
    
    row_vector = D_training(n_F_row,:); % form a row vector
    
    if nnz(row_vector) > 0 
        
        D_training(n_F_row,:) = row_vector ./ sqrt(nnz(row_vector)); % replace each row with the new row vector
        
    end
    
end 

F = D_training; % output F

end 
