% A function to take a datset ('D') and randomly produce two further datasets: a
% training set and a test set, based on a given fraction ('frac').

function [train_D,test_D] = random_split(dataset,frac)

% Calculate the dimensions of the dataset, rows => no. of rows
[rows,~] = size(dataset);

% Randomly allocate integers to each row and randomly select them
k = randperm(rows);

% Number of random rows required for the training dataset
p = frac*rows;

% Output training dataset
train_D = dataset(k(1:p),:);

% Output test dataset
test_D = dataset(k(p+1:end),:);

end

