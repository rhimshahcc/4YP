% A function that outputs a matrix of the correlation between the target
% row and all the other rows, across entries that are nonzero i.e. rated.

function user_corr_matrix = user_based_sim(row_pos,col_pos,D_training)

user_corr_matrix = [];

for n_row = 1:size(D_training,1) % iterate through all the rows
    
    if D_training(n_row,col_pos) ~= 0 % select rows which have rated the entry
          
        rows_matrix = []; % initialising a matrix to store all the nonzero values from the 2 rows being compared 
        
        for n_entry_comp = 1:size(D_training,2) % iterate through the entries in the 2 rows being compared
            
            if (D_training(n_row,n_entry_comp) ~= 0) && (D_training(row_pos,n_entry_comp) ~= 0) % check if both entries are nonzero
                
                nn_entry = D_training(n_row,n_entry_comp); % the nearest neighbour entry 
                comp_entry = D_training(row_pos,n_entry_comp); % the entry being analysed
                
                rows_matrix = [ rows_matrix ; nn_entry comp_entry]; % assign to a matrix that contains all the paired nonzero entries
            
            end
            
        end
        
        if size(rows_matrix,1) > 1
            
            corr_row = calc_pearson_corr(rows_matrix); % calculate the pearson correlation on rows_matrix, between the paired nonzero rows
            user_corr_matrix = [ user_corr_matrix ; n_row corr_row ]; % assign to a matrix that contains the row number and the correletion
            
        end
        
    end
    
end

end
