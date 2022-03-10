% A function to calculate the liklihood probability (item-based)

function item_likelihood = calc_item_likelihood(row_pos,col_pos,D_training,n_item_val)

row = D_training(row_pos,:); % extract the entry's row
col = D_training(:,col_pos); % extract the entry's col

% find the position of all the nonzero values in the row
[i,j,v] = find(row); 
nonzero_row = [i.' j.' v.']; % nonzero_row = [row col value]

cond_prob_values = []; % initialise an empty matrix

for n_val = 1:size(nonzero_row,1) % iterate through all the rated (nonzero) values in the row

    % find all the values in the entry's col that equal n_item_val
    [x,y,z] = find(col == n_item_val);  
    n_item_val_col = [x y z]; % n_item_val_col = [row col value]
    
    % extract the n_val col
    col_num = nonzero_row(n_val,2); % find the n_val col number
    col_n_val = D_training(:,col_num); % extract the n_val col
    
    % find all the values in the n_val col that equal the same value as in the entry's row 
    [w,t,p] = find(col_n_val == D_training(row_pos,col_num));  
    n_rated_val_col = [w t p]; % n_rated_val_col = [row col value]
    
    % find all the values in the n_val col that are nonzero
    [s,f,l] = find(col_n_val);  
    n_nonzero_val_col = [s f l]; % n_item_val_col = [row col value]
        
    % calculate the numerator: find similar rows, then sum the generated array   
    comp_value_vector_num = ismember(n_rated_val_col(:,1),n_item_val_col(:,1));        
    cond_prob_val_num = sum(comp_value_vector_num);
    
    % calculate the denominator: find similar rows, then sum the generated array  
    comp_value_vector_den = ismember(n_nonzero_val_col(:,1),n_item_val_col(:,1));
    cond_prob_val_den = sum(comp_value_vector_den);

    % divide through 
    cond_prob_val = cond_prob_val_num ./ cond_prob_val_den; % divide the numerator by the denominator

    cond_prob_values = [ cond_prob_values ; cond_prob_val ]; % add to a matrix of probability values

end

item_likelihood = prod(cond_prob_values); % multiply all the probability values to get the liklihood

end