% A function to select a random user row. 

function [user_row,row_number] = select_user_row(ratings_matrix)
 
row_number = randi(size(ratings_matrix,1)); % generate a random row number

user_row = ratings_matrix(row_number,:); % extract the row

nonzero_user_row = find(user_row).'; % matrix containing the col positions of all the nonzero values in user_row
zero_user_row = find(user_row == 0).'; % matrix containing the col positions of all the zero values in user_row

for n_nonzero = 1:size(nonzero_user_row,1) % replace all the nonzero (i.e. rated) values with '0'
    
    col_pos_nonzero = nonzero_user_row(n_nonzero,1); % extract the column position
    
    user_row(1,col_pos_nonzero) = 0;% extract the column position
    
end

for n_zero = 1:size(zero_user_row,1) % replace all the zero (i.e. unrated) values with '1'
    
    col_pos_zero = zero_user_row(n_zero,1); % extract the column position
    
    user_row(1,col_pos_zero) = 1; % extract the column position
    
end

end 
