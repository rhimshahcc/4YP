% Clear all previously defined variables
clear all
addpath('../../Generic Functions') 

% Datasets:
% Restaurant_Rec_ratings.txt
% Movie_Lens_Ratings.txt
% Yahoo_Music_Ratings.txt

txt_file = '../../Datasets/Restaurant_Rec_ratings.txt';
D = readmatrix(txt_file);
D = D(:,1:3);
ratings_matrix = make_ratings_matrix(D, txt_file); % form the ratings matrix

% Form a smaller test matrix
%test_matrix = make_test_matrix(ratings_matrix,500,500);
%ratings_matrix = test_matrix;

alpha = 0.5; % additive smoothing parameter 

% User Ranking
user_row = select_user_row(ratings_matrix); % Select a random row from the ratings matrix, replace all the 0s with 1s so that they are rated 
% insert the row into a blank matrix and assign to test_D

% Replace the rated entries with 0s
test_D = user_row; % let this be the test_D
D_training = ratings_matrix;
[~,pred_test] = naive_bayes(D_training,D_test,alpha); % Perform CF to predict the ratings of the 1s (i.e. the unrated items)
% Combine with the '0s' ratings, i.e. the rated items, JUST ADD THEM TOGETHER 
% Form ranking and output

% Business Ranking
% Rank items based on the objective
% Output the ranking list

% Vendor Ranking
% Group fairness: group items randomly into buckets
% Create an alternating ranking list from items from these buckets
% Note that this list would rotate every time the user requests a new recomendation list

alpha = 0.5; % additive smoothing parameter 





% Carry out naive bayes
tic
rmse_nb = naive_bayes(D_training,D_test,alpha)
toc

% Store each value in a vector
%rmse_nn_values = rmse_nn_values[:,rmse_nn]

% end

% mean(rmse_nn_values)

% Prevents orange errors from appearing in the workspace
warning off
