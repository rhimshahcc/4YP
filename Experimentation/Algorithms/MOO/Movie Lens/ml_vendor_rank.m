% A function to create a vendor ranking. 

function vendor_ranking = ml_vendor_rank(ratings_matrix,groups)

it_end = round(size(ratings_matrix,2) ./ groups); % number of iterations
groups_vector = []; % iitilaise a blank matrix

for n = 1:(it_end + 1)
    
    groups_vector = [groups_vector 1:groups]; % form the groups vector
    
end

groups_vector = groups_vector(:,1:size(ratings_matrix,2)); % eliminate excess values from the groups vector

vendor_ranking = [ groups_vector ; randperm(size(ratings_matrix,2)) ].'; % output the final vendor ranking

end 
