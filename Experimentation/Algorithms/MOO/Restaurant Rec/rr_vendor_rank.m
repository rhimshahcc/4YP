% A function to create a vendor ranking. 

function vendor_ranking = rr_vendor_rank(ratings_matrix,row_number)

user_row = ratings_matrix(row_number,:); % extract the row

zero_user_row = find(user_row == 0); % matrix containing the col positions of all the zero values ('novel') in user_row
nonzero_user_row = find(user_row); % matrix containing the col positions of all the nonzero values in user_row

vendor_ranking = [ ones(1,size(zero_user_row,2)) 2.*ones(1,size(nonzero_user_row,2))  ; zero_user_row nonzero_user_row ].'; % form the final vendor ranking

end 
