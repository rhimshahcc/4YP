% Clear all previously defined variables
clear all
addpath('../../../Generic Functions') 
addpath('../../MOO') 
addpath('../../Nearest Neighbour') 

%addpath('../../Matrix Factorisation') 
%addpath('../../Naive Bayes') 

% Form the ratings matrix
txt_file = '../../../Datasets/Movie_Lens_ratings.txt';
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
tic
[~,pred_test] = nearest_neighbour(D_training,D_test,k); % Perform CF to predict the ratings of the unrated items
pred_user_row = D_training(row_number,:) + pred_test(row_number,:); % Combine with the '0s' ratings, i.e. the rated items 

user_ranking = user_rank(pred_user_row); % Form user ranking 

% Vendor Ranking

groups = 5; % number of groups to split the movies into
vendor_ranking = ml_vendor_rank(ratings_matrix,groups); % Form vendor ranking 

% Business Ranking

business_ranking = ml_business_rank(ratings_matrix,row_number); % Form business ranking 

% MOO to form the final ranking

n = 80;
output_ranking_matrix = [];

while n < 450
    
    max_target_error = n;
    output_ranking = moo_epsilon(business_ranking,vendor_ranking,user_ranking,max_target_error);
    business_ranking_error = ranking_error(business_ranking,output_ranking);
    
    output_ranking_matrix = [output_ranking_matrix ; n business_ranking_error ];
    n = n + 10;
    
end

scatter(output_ranking_matrix(:,1),output_ranking_matrix(:,2));
xlabel('Max target Error for the User Ranking') % x axis is the item no.
ylabel('Business Ranking & Output Ranking Error') % y axis is the frequency of the item no.

%max_target_error = 450;
%output_ranking = moo_epsilon(user_ranking,vendor_ranking,business_ranking,max_target_error);

toc

% Ranking Error

all_rankings = [user_ranking(:,1) user_ranking(:,2) vendor_ranking(:,2) business_ranking(:,2) output_ranking(:,2)] % [rank user vendor business output]

user_ranking_error = ranking_error(user_ranking,output_ranking)
vendor_ranking_error = ranking_error(vendor_ranking,output_ranking)
business_ranking_error = ranking_error(business_ranking,output_ranking)

% Prevents orange errors from appearing in the workspace
warning off
