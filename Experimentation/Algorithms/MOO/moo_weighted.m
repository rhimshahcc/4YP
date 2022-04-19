% A function to create a final ranking using MOO. 

function output_ranking = moo_weighted(user_ranking,vendor_ranking,business_ranking)

list_length = size(user_ranking,1); % number of items

user_weight = 0.8; % weighting for the user ranking
vendor_weight = 0.1; % weighting for the vendor ranking 
business_weight = 0.1; % weighting for the business ranking

output_ranking = []; % initialise a blank matrix

for n = 1:list_length
    
    user_rank_pos = user_ranking(:,2) == n;
    user_rank = user_ranking(user_rank_pos,1);
    
    vendor_rank_pos = vendor_ranking(:,2) == n;
    vendor_rank = vendor_ranking(vendor_rank_pos,1);
    
    business_rank_pos = business_ranking(:,2) == n;
    business_rank = business_ranking(business_rank_pos,1);
    
    output_rank = (user_weight * user_rank) + (business_weight * business_rank) + (vendor_weight * vendor_rank);
    
    output_ranking = [ output_ranking ; output_rank n ]; % [output_rank item_no.]
    
end

output_ranking = sortrows(output_ranking,1,'ascend'); % sort the list by the value i.e. the 2nd col
output_ranking = [1:list_length ; output_ranking(:,2).'].';

end 
