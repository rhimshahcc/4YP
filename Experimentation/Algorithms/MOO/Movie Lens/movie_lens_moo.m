% Clear all previously defined variables
clear all
addpath('../../../Generic Functions') 
addpath('../../MOO') 
addpath('../../Nearest Neighbour') 

%addpath('../../Matrix Factorisation') 
%addpath('../../Naive Bayes') 

% Form the ratings matrix
txt_file = '../../../Datasets/movie_lens_ratings.txt';
D = readmatrix(txt_file);
D = D(:,1:3);
ratings_matrix = make_ratings_matrix(D, txt_file); % form the ratings matrix

% Form a smaller test matrix
test_matrix = make_test_matrix(ratings_matrix,1200,1200);
ratings_matrix = test_matrix;

% Inputs
k = 25; % Select the top k% similar rows/col

% User Ranking

[user_row,row_number] = select_user_row(ratings_matrix); % select a random row from the ratings matrix, switch values 
D_test = zeros(size(ratings_matrix,1),size(ratings_matrix,2)); % generate a blank matrix 
D_test(row_number,:) = user_row; % insert the user_row into a blank matrix and assign to test_D
D_training = ratings_matrix; % the training dataset is the whole ratings matrix

[~,pred_test] = nearest_neighbour(D_training,D_test,k); % Perform CF to predict the ratings of the unrated items
pred_user_row = D_training(row_number,:) + pred_test(row_number,:); % Combine with the '0s' ratings, i.e. the rated items 

user_ranking = user_rank(pred_user_row) % Form user ranking 

% Vendor Ranking

groups = 5; % number of groups to split the movies into
%vendor_ranking = rr_vendor_rank(ratings_matrix,row_number,groups) % Form vendor ranking 

% Business Ranking

original_content = 40 ; % percentage of the items that are classed as 'original content'
business_ranking = ml_business_rank(ratings_matrix,row_number,original_content) % Form business ranking 

% MOO to form the final ranking
combined_ranking = [user_ranking(:,1) user_ranking(:,2) vendor_ranking(:,2) business_ranking(:,2)] % [rank user vendor business] 
%output_ranking = moo(user_ranking,business_ranking,vendor_ranking);


% Prevents orange errors from appearing in the workspace
warning off
