% Clear all previously defined variables
clear all
addpath('../../Generic Functions') 

% Datasets:

% Restaurant_Rec_ratings.txt
% Yahoo_Music_Ratings.txt
% Movie_Lens_Ratings.txt

% Form the data matrix
txt_file = '../Datasets/Restaurant_Rec_ratings.txt';
D = readmatrix(txt_file);

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D, txt_file);

% Form a smaller test matrix
%test_matrix = make_test_matrix(ratings_matrix,1200,1200);
%ratings_matrix = test_matrix;

% Ratings matrix information

users = size(ratings_matrix,1) % number of users
items = size(ratings_matrix,2) % number of items
total_entries = users * items % total no. of entries

unique_ratings = unique(ratings_matrix);
unique_ratings = unique_ratings(2:end,:) % unique ratings (excluding '0' which is classed as unrated
number_of_unique_ratings = size(unique_ratings,1) % number of unique ratings

sparsity = calc_sparsity(ratings_matrix) % sparsity
number_of_ratings = sparsity./100 * total_entries

[nonzero_rows_0,nonzero_col_0] = nonzero_entries_counter(ratings_matrix,0); % no. of rows/col with 0 nonzero values
[nonzero_rows_1,nonzero_col_1] = nonzero_entries_counter(ratings_matrix,1); % no. of rows/col with 1 nonzero values
nonzero_rows = nonzero_rows_0 + nonzero_rows_1
nonzero_col = nonzero_col_0 + nonzero_col_1

plot_long_tail(ratings_matrix) % long tail plot of ratings frequency

% Prevents orange errors from appearing in the workspace
warning off
