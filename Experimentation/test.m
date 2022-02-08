% Clear all previously defined variables
clear all

% Datasets:

% Restaurant_Rec_ratings.txt = 1
% Yahoo_Music_Ratings.txt = 2
% Movie_Lens_Ratings.txt = 3

% Form the data matrix
D = readmatrix('Datasets/Yahoo_Music_Ratings.txt');
dataset_type = 2;

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D, dataset_type);

% Calculate the sparsity of the ratings matrix
sparsity = calc_sparsity(ratings_matrix)

% Plot the long tail graph of the ratings matrix, showing the frequency of
% rated items.
plot_long_tail(ratings_matrix)



% Prevents orange errors from appearing in the workspace
warning off
