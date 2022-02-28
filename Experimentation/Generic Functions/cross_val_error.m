% A function to check how many values have changed after cross-validation.

function error = cross_val_error(ratings_matrix,D_split,split)

D_split_sum = D_split{1};

% Recursively sum all the folds
if split > 1
    for n = 1:(split-1)
    
        D_split_sum = D_split_sum + D_split{n+1};
    
    end
end 

result = ratings_matrix == D_split_sum; % compare
error = sum(result(:)==0); % count the number of cells that don't match

end

