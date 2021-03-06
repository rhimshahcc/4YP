% A function to create a pareto front of the final ranking using MOO. 

function output_ranking = moo_pareto(user_ranking,vendor_ranking,business_ranking,max_target_error)

list_length = size(user_ranking,1); % number of items 

% create a combined ranking from the business_ranking and the vendor_ranking

business_weight = 0.5; % weighting for the user ranking
vendor_weight = 0.5; % weighting for the vendor ranking 

combined_ranking = []; % initialise a blank matrix

for n = 1:list_length
    
    business_rank_pos = business_ranking(:,2) == n; % position of the new rank
    business_rank = business_ranking(business_rank_pos,1); % corresponding value
    
    vendor_rank_pos = vendor_ranking(:,2) == n; % position of the vendor rank
    vendor_rank = vendor_ranking(vendor_rank_pos,1); % corresponding value
    
    combined_rank = (business_weight * business_rank) + (vendor_weight * vendor_rank);
    
    combined_ranking = [ combined_ranking ; combined_rank n ]; % [combined_rank item_no.]
    
end

combined_ranking = sortrows(combined_ranking,1,'ascend'); % sort the list by the value i.e. the 2nd col
combined_ranking = [1:list_length ; combined_ranking(:,2).'].';

combined_ranking_sorted = sortrows(combined_ranking,2,'ascend'); % [ combined_rank item_no. ], the item no. is in order

new_ranking = user_ranking; % fix the user ranking as the starting point

actual_target_error = ranking_error(business_ranking,new_ranking); % initial error between the two rankings

while actual_target_error > max_target_error % user_ranking --> (tends to) --> business_ranking
    
    % Relist the new ranking
    new_ranking_sorted = sortrows(new_ranking,2,'ascend'); % [ new_rank item_no. ], ordered by item no.
    
    % Error
    E = combined_ranking_sorted(:,1) - new_ranking_sorted(:,1);
    
    % new_rank = new_rank + step*error
    next_new_ranking = new_ranking_sorted(:,1) + 0.05*E;
    
    % reorder new_rank [rank item_no.] to form new_ranking
    new_ranking_unordered = [ (1:list_length).' next_new_ranking ]; % [ item_no. rank_score] unordered
    new_ranking_ordered = sortrows(new_ranking_unordered,2,'ascend'); % [ item_no. rank_score], ordered by rank_score
    new_ranking = [ (1:list_length).' new_ranking_ordered(:,1) ]; % [rank item_no.] ordered
    
    % calculate the new error between new_ranking and business_ranking
    actual_target_error = ranking_error(business_ranking,new_ranking); % new error between the two rankings
    
end

output_ranking = new_ranking;

end 

