% A function to randomly generate 'split' folds from the original ratings
% matrix.

function D_split = cross_validation_nn(input_ratings_matrix,split)

rows = size(input_ratings_matrix,1); % number of rows
col = size(input_ratings_matrix,2); % number of col
nonzero_cells = nnz(input_ratings_matrix); % number of nonzero entries

[i,j,v] = find(input_ratings_matrix); % location of nonzero values 
cross_val_info = [i j v]; % matrix of nonzero values

% Nnumber of nonzero entries in each fold
nonzero_fold = nonzero_cells ./ split ;

% Vector of random numbers
rand_num = randperm(nonzero_cells);

% Split the matrix of nonzero values into 'split' folds
for n_cross_val = 1:split
    
    start_pt = (nonzero_fold * (n_cross_val-1)) + 1; % start point
    end_pt = nonzero_fold * n_cross_val; % end point
    
    % Store each fold in D_cross_val, which can be referenced via {}
    D_cross_val{n_cross_val} = cross_val_info(rand_num(start_pt:end_pt),:);
    
end

% Reformulate the ratings matrices from each fold
for n = 1:split
    
    D_split{n} = zeros(rows,col); % matrix of zeros
    
    for n_reform = 1:nonzero_fold
    
        % Select the values from D_cross_val
        row_pos = D_cross_val{n}(n_reform,1); % row position
        col_pos = D_cross_val{n}(n_reform,2); % col position
        new_entry = D_cross_val{n}(n_reform,3); % new entry

        % Update the matrix of zeros with the values from D_cross_val
        D_split{n}(row_pos,col_pos) = new_entry; 

    end
    
end 

end
