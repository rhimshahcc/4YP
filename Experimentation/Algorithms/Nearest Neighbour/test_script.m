% Clear all previously defined variables
clear all
addpath('../../Generic Functions') 

% Datasets:
% Restaurant_Rec_Ratings.txt
% Movie_Lens_Ratings.txt
% Yahoo_Music_Ratings.txt

% Form the data matrix
txt_file = '../../Datasets/Movie_Lens_Ratings.txt';
D = readmatrix(txt_file);
D = D(:,1:3);
ratings_matrix = make_ratings_matrix(D, txt_file); % form the ratings matrix

% Form a smaller test matrix
test_matrix = make_test_matrix(ratings_matrix,1200,1200);
ratings_matrix = test_matrix;

% Inputs
split = 4; % number of cross-validation folds
k = 25; % Select the top k% similar rows/col

% Cross Validation
D_split = cross_validation_nn(ratings_matrix,split);
error = cross_val_error(ratings_matrix,D_split,split); % Check how many values have changed after cross-validation

% Form the training/test datasets from the cross validation folds
[D_training,D_test] = form_train_test(D_split,split);

% Carry our nearest neighbour
tic
%[rmse_nn,~] = nearest_neighbour(D_training,D_test,k)
toc


% ITERATION SCRIPT TO FIND THE BEST K
store_k = [];
n_k = 10;

while n_k < 16
    
    n_k
    [rmse_nn,~] = nearest_neighbour(D_training,D_test,n_k);
    store_k = [store_k ; n_k rmse_nn];
    
    n_k = n_k + 5;

end

plot(store_k(:,1),store_k(:,2));

% Prevents orange errors from appearing in the workspace
warning off
