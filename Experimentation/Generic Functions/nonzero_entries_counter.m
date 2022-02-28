% A function to count the number of rows/columns with a specified (P) number of nonzero entries.

function [nonzero_rows,nonzero_col] = nonzero_entries_counter(ratings_matrix,P)

% vector of the number of nonzero ratings in each row 
x = [];
i = 1;

while i < size(ratings_matrix,1) + 1
   x(i) = sum(ratings_matrix(i,:)~=0);
   i = i + 1;
end 

% vector of the number of nonzero ratings in each column
y = [];
j = 1;

while j < size(ratings_matrix,2) + 1
   y(j) = sum(ratings_matrix(:,j)~=0);
   j = j + 1;
end 

% counter
nonzero_rows = sum(x(:) == P); % number of rows with P nonzero entries
nonzero_col = sum(y(:) == P); % number of columns with P nonzero entries


end