% Script to plot the long tails on a single graph

clear all
addpath('../Generic Functions') 

% RESTAURANT REC

% Form the data matrix
txt_file = '../Datasets/Restaurant_Rec_Ratings.txt';
D = readmatrix(txt_file);

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D, txt_file);

long_tail = plot_long_tail(ratings_matrix); % long tail plot of ratings frequency
rr_x_scaled = (long_tail(:,1).*100)/size(long_tail,1);
rr_y_scaled = (long_tail(:,2).* 100)/long_tail(1,2);


% MOVIE LENS

% Form the data matrix
txt_file = '../Datasets/Movie_Lens_Ratings.txt';
D = readmatrix(txt_file);

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D, txt_file);

% Form a smaller test matrix
test_matrix = make_test_matrix(ratings_matrix,1200,1200);
ratings_matrix = test_matrix;

long_tail = plot_long_tail(ratings_matrix); % long tail plot of ratings frequency
ml_x_scaled = (long_tail(:,1).*100)/size(long_tail,1);
ml_y_scaled = (long_tail(:,2).* 100)/long_tail(1,2);


% YAHOO MUSIC

% Form the data matrix
txt_file = '../Datasets/Yahoo_Music_Ratings.txt';
D = readmatrix(txt_file);

% Form the ratings matrix
ratings_matrix = make_ratings_matrix(D, txt_file);

% Form a smaller test matrix
test_matrix = make_test_matrix(ratings_matrix,500,500);
ratings_matrix = test_matrix;

long_tail = plot_long_tail(ratings_matrix); % long tail plot of ratings frequency
ym_x_scaled = (long_tail(:,1).*100)/size(long_tail,1);
ym_y_scaled = (long_tail(:,2).* 100)/long_tail(1,2);

% SMOOTH

plot(smooth(rr_x_scaled),smooth(rr_y_scaled),smooth(ml_x_scaled),smooth(ml_y_scaled),smooth(ym_x_scaled),smooth(ym_y_scaled))
xlabel('Ranked Item Number by Popularity (Scaled)') % x axis is the item no.
ylabel('Frequency of Each Item (Scaled)') % y axis is the frequency of the item no.
legend('Restaurant Rec Dataset','Movie Lens Dataset','Yahoo Music Dataset')


