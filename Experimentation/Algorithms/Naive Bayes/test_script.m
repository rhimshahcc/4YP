% Clear all previously defined variables
clear all
addpath('../../Generic Functions') 

% Datasets:
% Restaurant_Rec_Ratings.txt
% Movie_Lens_Ratings.txt
% Yahoo_Music_Ratings.txt

txt_file = '../../Datasets/Yahoo_Music_Ratings.txt';
D = readmatrix(txt_file);
D = D(:,1:3);
ratings_matrix = make_ratings_matrix(D, txt_file); % form the ratings matrix

% Form a smaller test matrix
test_matrix = make_test_matrix(ratings_matrix,500,500);
ratings_matrix = test_matrix;

% Inputs
split = 4; % number of cross-validation folds
alpha = 0.15; % additive smoothing parameter 

% Cross Validation
D_split = cross_validation_nn(ratings_matrix,split);
error = cross_val_error(ratings_matrix,D_split,split); % check how many values have changed after cross-validation

% for n = 1:split

% Form the training/test datasets from the cross validation folds
[D_training,D_test] = form_train_test(D_split,split);

% Carry out naive bayes
tic
[rmse_nb,~] = naive_bayes(D_training,D_test,alpha)
toc

% Store each value in a vector
%rmse_nn_values = rmse_nn_values[:,rmse_nn]

% end

% mean(rmse_nn_values)

% Prevents orange errors from appearing in the workspace
warning off
