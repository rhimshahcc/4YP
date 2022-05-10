% Clear all previously defined variables
clear all
addpath('../../Generic Functions') 

% Datasets:
% Restaurant_Rec_Rsatings.txt
% Movie_Lens_Ratings.txt
% Yahoo_Music_Ratings.txt

% Form the data matrix
txt_file = '../../Datasets/Yahoo_Music_Ratings.txt';
D = readmatrix(txt_file);
D = D(:,1:3);
ratings_matrix = make_ratings_matrix(D, txt_file); % form the ratings matrix

% Form a smaller test matrix
test_matrix = make_test_matrix(ratings_matrix,500,500);
ratings_matrix = test_matrix;

% Inputs
split = 4; % number of cross-validation folds

% Cross Validation
D_split = cross_validation_nn(ratings_matrix,split);
error = cross_val_error(ratings_matrix,D_split,split); % check how many values have changed after cross-validation

% Form the training/test datasets from the cross validation folds
[D_training,D_test] = form_train_test(D_split,split);

% Inputs
step = 0.0001; % gradient descent step value 
rank_k = 10; % directly input k
conv_crit = 0.001; % convergence criterion
lambda = 0.25; % regularisation term (to prevent overfitting)

% Carry our MF
tic
[rmse_mf,~,it_rmse] = matrix_factorisation_un_stochastic(D_training,D_test,step,rank_k,lambda,conv_crit)
toc


%{
% ITERATION SCRIPT TO FIND THE BEST K

av_store_rmse = [];

for n_it = 1:3
    
    store_rmse = [];
    
    for n_k = 2:20

        % Inputs
        step = 0.0001; % gradient descent step value 
        rank_k = n_k; % directly input k
        conv_crit = 0.0001; % convergence criterion
        lambda = 0; % regularisation term (to prevent overfitting)

        % Carry our MF
        [rmse_mf,~] = matrix_factorisation_un_svd(D_training,D_test,step,rank_k,lambda,conv_crit);

        store_rmse = [ store_rmse ; rmse_mf];

    end
    
    av_store_rmse = [ av_store_rmse ; store_rmse.' ];
    
end

plot_rmse = [ 2:20 ; mean(av_store_rmse,1) ].';

plot(plot_rmse(:,1),plot_rmse(:,2))
%}

%{
% ITERATION SCRIPT TO FIND THE BEST LAMBDA (FOR SVD++)

av_store_rmse = [];

for n_it = 1:2
    
    store_rmse = [];
    n_lambda = 0.05;
    n_lambda_vector = [];
    
    while n_lambda < 0.4
        
        n_lambda_vector = [n_lambda_vector ; n_lambda];
        
        % Inputs
        step = 0.0001; % gradient descent step value 
        rank_k = 10; % directly input k
        conv_crit = 0.0001; % convergence criterion
        lambda = n_lambda; % regularisation term (to prevent overfitting)

        % Carry our MF
        [rmse_mf,~] = matrix_factorisation_un_svd(D_training,D_test,step,rank_k,lambda,conv_crit);

        store_rmse = [ store_rmse ; rmse_mf];
        
        n_lambda = n_lambda + 0.01;

    end
    
    av_store_rmse = [ av_store_rmse ; store_rmse.' ];
    
end

plot_rmse = [ n_lambda_vector.' ; mean(av_store_rmse) ].';

plot(plot_rmse(:,1),plot_rmse(:,2))
%}

% Prevents orange errors from appearing in the workspace
warning off
