% A function to create a final ranking using MOO. 

function output_ranking = moo_epsilon(user_ranking,vendor_ranking,business_ranking,max_target_error)

list_length = size(user_ranking,1); % number of items 

business_ranking_sorted = sortrows(business_ranking,2,'ascend'); % [ business_rank item_no. ], the item no. is in order

new_ranking = user_ranking; % fix the user ranking as the starting point

actual_target_error = ranking_error(business_ranking,new_ranking); % initial error between the two rankings

while actual_target_error > max_target_error % user_ranking --> (tends to) --> business_ranking
    
    % Relist the new ranking
    new_ranking_sorted = sortrows(new_ranking,2,'ascend'); % [ new_rank item_no. ], ordered by item no.
    
    % Error
    E = business_ranking_sorted(:,1) - new_ranking_sorted(:,1);
    
    % new_rank = new_rank + step*error
    next_new_ranking = new_ranking_sorted(:,1) + 0.05*E;
    
    % reorder new_rank [rank item_no.] to form new_ranking
    new_ranking_unordered = [ (1:list_length).' next_new_ranking ]; % [ item_no. rank_score] unordered
    new_ranking_ordered = sortrows(new_ranking_unordered,2,'ascend'); % [ item_no. rank_score], ordered by rank_score
    new_ranking = [ (1:list_length).' new_ranking_ordered(:,1) ]; % [rank item_no.] ordered
    
    % calculate the new error between new_ranking and business_ranking
    actual_target_error = ranking_error(business_ranking,new_ranking); % new error between the two rankings
    
end

% adding in vendor_rank to form output_ranking
old_vendor_ranking = vendor_ranking;

rank_no = 1; % initialise rak_no, first we need to find the first item with rank '1'
groups_matrix = []; % initilaise a matrix to store the new rankings

rank_one = 0;
rank_two = 0;
rank_three = 0;
rank_four = 0;
rank_five = 0;

for n_vendor = 1:list_length
        
    item_no_vendor = new_ranking(n_vendor,2);

    vendor_item_pos = vendor_ranking(:,2) == item_no_vendor; % position of the vendor item
    vendor_rank_value = vendor_ranking(vendor_item_pos,1); % corresponding rank
    
    % select the first item with a '1' and add that as its ranking 
    if vendor_rank_value == 1 && rank_one ~= 1

        groups_matrix = [ groups_matrix ; 1 item_no_vendor ];
        rank_one = 1;
        
    elseif vendor_rank_value == 2 && rank_two ~= 1
        
        groups_matrix = [ groups_matrix ; 2 item_no_vendor ];
        rank_two = 1;
        
    elseif vendor_rank_value == 3 && rank_three ~= 1
        
        groups_matrix = [ groups_matrix ; 3 item_no_vendor ];
        rank_three = 1;
        
    elseif vendor_rank_value == 4 && rank_four ~= 1
        
        groups_matrix = [ groups_matrix ; 4 item_no_vendor ];
        rank_four = 1;
        
    elseif vendor_rank_value == 5 && rank_five ~= 1
        
        groups_matrix = [ groups_matrix ; 5 item_no_vendor ];
        rank_five = 1;
        
    else 
        
        groups_matrix = [ groups_matrix ; 6 item_no_vendor ];

    end
    
end

vendor_ranking = groups_matrix;

% form the final output_ranking from new_ranking and vendor_ranking

new_weight = 0.5; % weighting for the user ranking
vendor_weight = 0.5; % weighting for the vendor ranking 

output_ranking = []; % initialise a blank matrix

for n = 1:list_length
    
    new_rank_pos = new_ranking(:,2) == n; % position of the new rank
    new_rank = new_ranking(new_rank_pos,1); % corresponding value
    
    vendor_rank_pos = vendor_ranking(:,2) == n; % position of the vendor rank
    vendor_rank = vendor_ranking(vendor_rank_pos,1); % corresponding value
    
    output_rank = (new_weight * new_rank) + (vendor_weight * vendor_rank);
    
    output_ranking = [ output_ranking ; output_rank n ]; % [output_rank item_no.]
    
end

output_ranking = sortrows(output_ranking,1,'ascend'); % sort the list by the value i.e. the 2nd col
output_ranking = [1:list_length ; output_ranking(:,2).'].';

end 
