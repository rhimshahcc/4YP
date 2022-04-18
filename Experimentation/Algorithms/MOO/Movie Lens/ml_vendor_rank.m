% A function to create a vendor ranking. 

function vendor_ranking = rr_vendor_rank(ratings_matrix,row_number,groups)

user_row = ratings_matrix(row_number,:); % extract the row


% randomly assign numbers 1-5 to the items
% select 
 
nonzero_user_row = find(user_row); % matrix containing the col positions of all the nonzero values in user_row

vendor_ranking = [ ones(1,size(nonzero_user_row,2)) ; nonzero_user_row ].';

end 
