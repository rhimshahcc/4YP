% A function to create a business ranking. 

function business_ranking = ml_business_rank(ratings_matrix,row_number)

user_row = ratings_matrix(row_number,:); % extract the row
 
row_length = size(user_row,2); % length of the row (i.e. number of items)

business_values = rand(1,row_length) * 20; % row vector of the movie length values for each item
    
unordered_ranking = [1:size(business_values,2) ; business_values].'; % assign an item no. to each item
ordered_ranking = sortrows(unordered_ranking,2,'descend'); % sort the list by the value i.e. the 2nd col

business_ranking = [1:size(business_values,2) ; ordered_ranking(:,1).'].'; % generate the final ranking list, [ranking item]

end 