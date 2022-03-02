% Clear all previously defined variables
clear all
addpath('../Generic Functions') 

% Datasets:
% Restaurant_Rec_ratings.txt
% Yahoo_Music_Ratings.txt
% Movie_Lens_Ratings.txt

% Form the data matrix
txt_file = '../../Datasets/Restaurant_Rec_ratings.txt';
D = readmatrix(txt_file);
size(D);

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D, txt_file);

% Cross Validation
split = 4;
D_split = cross_validation_nn(ratings_matrix,split);

% Check how many values have changed after cross-validation
error = cross_val_error(ratings_matrix,D_split,split);

% for n = 1:split

% Form the training/test datasets from the cross validation folds
[D_training,D_test] = form_train_test(D_split,split);

% Carry our nearest neighbour
rmse_nn = nearest_neighbour(D_training,D_test);

% Store each value in a vector
%rmse_nn_values = rmse_nn_values[:,rmse_nn]

% end

% mean(rmse_nn_values)

% Prevents orange errors from appearing in the workspace
warning off
