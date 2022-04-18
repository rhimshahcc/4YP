% Clear all previously defined variables
clear all
addpath('../../../Generic Functions') 
addpath('../../MOO') 
addpath('../../Matrix Factorisation') 

%addpath('../../Nearest Neighbour') 
%addpath('../../Naive Bayes') 

% Form the ratings matrix

txt_file = '../../../Datasets/Restaurant_Rec_ratings.txt';
D = readmatrix(txt_file);
D = D(:,1:3);
ratings_matrix = make_ratings_matrix(D, txt_file); % form the ratings matrix

% Inputs
step = 0.001; % gradient descent step value 
rank_k = 6;
conv_crit = 0.000001; % convergence criterion
lambda = 0.08; % regularisation term (to prevent overfitting)

% User Ranking

[user_row,row_number] = select_user_row(ratings_matrix); % select a random row from the ratings matrix, switch values 
D_test = zeros(size(ratings_matrix,1),size(ratings_matrix,2)); % generate a blank matrix 
D_test(row_number,:) = user_row; % insert the user_row into a blank matrix and assign to test_D
D_training = ratings_matrix; % the training dataset is the whole ratings matrix

[~,pred_test] = matrix_factorisation_un_batch(D_training,D_test,step,rank_k,lambda,conv_crit); % Perform CF to predict the ratings of the unrated items
pred_user_row = D_training(row_number,:) + pred_test(row_number,:); % Combine with the '0s' ratings, i.e. the rated items 

user_ranking = user_rank(pred_user_row) % Form user ranking 

% Vendor Ranking

vendor_ranking = rr_vendor_rank(ratings_matrix,row_number) % Form vendor ranking 

% Business Ranking

business_ranking = rr_business_rank(ratings_matrix,row_number) % Form business ranking 

% MOO to form the final ranking

%output_ranking = moo(user_ranking,business_ranking,vendor_ranking);


% Prevents orange errors from appearing in the workspace
warning off