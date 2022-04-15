% Clear all previously defined variables
clear all
addpath('../../Generic Functions') 
addpath('../Nearest Neighbour') 
addpath('../Naive Bayes') 
addpath('../Matrix Factorisation') 

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

[user_row,row_number] = select_user_row(ratings_matrix); % select a random row from the ratings matrix, switch values 
D_test = zeros(size(ratings_matrix,1),size(ratings_matrix,2)); % generate a blank matrix 
D_test(row_number,:) = user_row; % insert the user_row into a blank matrix and assign to test_D
D_training = ratings_matrix; % the training dataset is the whole ratings matrix

[~,pred_test] = naive_bayes(D_training,D_test,alpha); % Perform CF to predict the ratings of the unrated items
pred_user_row = D_training(row_number,:) + pred_test(row_number,:); % Combine with the '0s' ratings, i.e. the rated items 
user_ranking = user_rank(pred_user_row); % Form ranking and output

% Business Ranking

% Rank items based on the objective
% Output the ranking list
business_ranking

% Vendor Ranking

% Group fairness: group items randomly into buckets
% Create an alternating ranking list from items from these buckets
% Note that this list would rotate every time the user requests a new recomendation list
vendor_ranking

% MOO to form thee final ranking 
output_ranking = moo(user_ranking,business_ranking,vendor_ranking);


% Prevents orange errors from appearing in the workspace
warning off
