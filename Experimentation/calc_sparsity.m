% A function to plot the long tail of a ratings matrix.

function sparsity = calc_sparsity(ratings_matrix)

% Calculate the number of rows
rows = size(ratings_matrix,1);

% Calculate the number of columns
col = size(ratings_matrix,2);

% Calculate the number of empty cells
empty_cells = sum(ratings_matrix(:) == 0);

% Sparsity = percentage of cells with nonzero values
sparsity = 100 - ((empty_cells ./ (rows * col)) * 100);

end

