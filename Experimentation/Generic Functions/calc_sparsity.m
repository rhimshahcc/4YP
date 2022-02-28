% A function to plot the long tail of a ratings matrix.

function sparsity = calc_sparsity(ratings_matrix)

% Calculate the number of rows
rows = size(ratings_matrix,1);

% Calculate the number of columns
col = size(ratings_matrix,2);

% Calculate the number of nonzero cells
nonzero_cells = nnz(ratings_matrix);

% Sparsity = percentage of cells with nonzero values
sparsity = (nonzero_cells ./ (rows * col)) * 100;

end

