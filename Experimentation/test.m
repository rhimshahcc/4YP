% Clear all previously defined variables
clear all

% Datasets:

% Restaurant_Rec_ratings.txt
% Yahoo_Music_Ratings.txt
% Movie_Lens_Ratings.txt

% Form the data matrix
D = readmatrix('Datasets/Yahoo_Music_Ratings.txt');

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D);

% Calculate the sparsity of the ratings matrix
sparsity = calc_sparsity(ratings_matrix)

% Plot the long tail graph of the ratings matrix, showing the frequency of
% rated items.
plot_long_tail(ratings_matrix)


% D = normalize(D)

% Prevents orange errors from appearing in the workspace
warning off
