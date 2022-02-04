% A function to plot the long tail of a ratings matrix.

function cross_validation(input_ratings_matrix,split)

% Counts the number of nonzero values in each column and turns it into a
% row vector.
long_tail = sum(input_ratings_matrix~=0);

% Sorts the row vector into descending order.
long_tail = sort(long_tail,'descend');

% Transposes the row vector into a column vector. 
long_tail = transpose(long_tail);

% Plot a bar graph.
bar(long_tail(:,1))

end

