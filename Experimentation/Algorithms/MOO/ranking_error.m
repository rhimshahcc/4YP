% A function to measure the rank error between two rankings. 

function rank_error = ranking_error(target_ranking,output_ranking)

list_length = size(target_ranking,1); % number of items
rank_error_matrix = []; % initialise the matrix to hold the error values

for n = 1:list_length
    
    target_rank_pos = target_ranking(:,2) == n; % locate the item number
    target_rank_value = target_ranking(target_rank_pos,1); % identify the rank position for the item number
    
    output_rank_pos = output_ranking(:,2) == n; % locate the item number
    output_rank_value = output_ranking(output_rank_pos,1); % identify the rank position for the item number
    
    rank_error_value = (target_rank_value - output_rank_value).^2; % error between the two values
    
    rank_error_matrix = [ rank_error_matrix ; rank_error_value ]; % add the error to a matrix
    
end

rank_error = sqrt(sum(rank_error_matrix) ./ list_length); % calculate the RMSE 

end 
