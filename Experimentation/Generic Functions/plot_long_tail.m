% A function to plot the long tail of a ratings matrix.

function long_tail = plot_long_tail(ratings_matrix)

% Counts the number of nonzero values in each column and turns it into a row vector.
long_tail = sum(ratings_matrix~=0);

% Sorts the row vector into descending order.
long_tail = sort(long_tail,'descend');

% Transposes the row vector into a column vector. 
long_tail = [ 1:size(long_tail,2) ; long_tail].';

% Plot a bar graph.
plot(long_tail(:,1),long_tail(:,2));
xlabel('Ranked item number by popularity') % x axis is the item no.
ylabel('Frequency of each item') % y axis is the frequency of the item no.

end

