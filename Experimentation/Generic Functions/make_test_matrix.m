% A function to form a x x y subset test ratings matrix of a larger input matrix.

function [test_ratings_matrix] = make_test_matrix(input_ratings_matrix,users,items)

% Form the specififed test matrix based on the number of users/items
% specified
test_ratings_matrix = input_ratings_matrix(1:users,1:items);

end