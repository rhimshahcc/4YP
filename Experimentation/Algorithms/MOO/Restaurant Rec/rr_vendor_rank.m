% A function to create a vendor ranking user row. 

function vendor_ranking = vendor_rank(ratings_matrix,row_number)

user_row = ratings_matrix(row_number,:); % extract the row
 
nonzero_user_row = find(user_row).'; % matrix containing the col positions of all the nonzero values in user_row

nnz(user_row

end 
