
% A function that outputs a matrix of the correlation between the target
% column and all the other columns, across entries that are nonzero i.e. rated.

function item_corr_matrix = item_based_sim(row_pos,col_pos,D_training)

item_corr_matrix = [];
item_error_entries = 0;

for n_col = 1:size(D_training,2) % iterate through all the columns
    
    if D_training(row_pos,n_col) ~= 0 % select columns which have rated the entry
          
        col_matrix = []; % initialising a matrix to store all the nonzero values from the 2 col being compared 
        
        for n_entry_comp = 1:size(D_training,1) % iterate through the entries in the 2 col being compared
            
            if (D_training(n_entry_comp,n_col) ~= 0) && (D_training(n_entry_comp,col_pos) ~= 0) % check if both entries are nonzero
                
                nn_entry = D_training(n_entry_comp,n_col); % the nearest neighbour entry 
                comp_entry = D_training(n_entry_comp,col_pos); % the entry being analysed
                
                col_matrix = [ col_matrix ; nn_entry comp_entry]; % assign to a matrix that contains all the paired nonzero col
            
            end
            
        end
        
        corr_col = corrcoef(col_matrix); % calculate the pearson correlation on col_matrix, between the paired nonzero entries
        nan_elements = isnan(corr_col); % check for any nan elements
        
        % Select the correlation between A,B 
        if (size(corr_col,1) == 1) && (nnz(nan_elements) == 0)
            
            corr_col_A_B = corr_col(1,1);
            item_corr_matrix = [ item_corr_matrix ; n_col corr_col_A_B ]; % assign to a matrix that contains the col number and the correletion
            
        elseif (size(corr_col,1) > 1) && (nnz(nan_elements) == 0)
            
            corr_col_A_B = corr_col(1,2);
            item_corr_matrix = [ item_corr_matrix ; n_col corr_col_A_B ]; % assign to a matrix that contains the col number and the correletion
            
        else 
            
            % ...else... the col being analysed can not be used for the nearest
            % neighbour, and is therefore not added to the
            % item_corr_matrix, however other col can be used
                       
        end 
        
    end
    
end

end
