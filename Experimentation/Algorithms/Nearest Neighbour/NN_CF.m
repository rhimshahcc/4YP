% Clear all previously defined variables
clear all
addpath('../Generic Functions') 

% Datasets:

% Restaurant_Rec_ratings.txt
% Yahoo_Music_Ratings.txt
% Movie_Lens_Ratings.txt

% Form the data matrix
txt_file = '../Datasets/Movie_Lens_Ratings.txt';
D = readmatrix(txt_file);

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D, txt_file);

% Form a smaller test matrix
test_matrix = make_test_matrix(ratings_matrix,10,10);

% Ratings matrix information
[nonzero_rows,nonzero_col] = nonzero_entries_counter(ratings_matrix,0) % non zero entries
sparsity = calc_sparsity(ratings_matrix) % sparsity
plot_long_tail(ratings_matrix) % long tail plot of ratings frequency

% Prevents orange errors from appearing in the workspace
warning off
