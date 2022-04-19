% A function to create a business ranking. 

function business_ranking = ml_business_rank(ratings_matrix,row_number,original_content)

user_row = ratings_matrix(row_number,:); % extract the row
row_length = size(user_row,2); % length of the row (i.e. number of items)
 
original_row_length = round((original_content ./ 100) * row_length); % length of the original content row, '1s'
other_row_length = row_length - original_row_length; % length of the other content row, '0s'

random_user_row = randperm(row_length); % row of random numbers, representing the item numbers
original_user_rows = random_user_row(:,1:original_row_length); % original content item numbers
other_user_rows = random_user_row(:,original_row_length+1:row_length); % other content item numbers

business_ranking = [ ones(1,original_row_length) 2.*ones(1,other_row_length)  ; original_user_rows other_user_rows ].'; % form the final business ranking

end 
