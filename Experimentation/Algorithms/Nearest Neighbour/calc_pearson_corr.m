% A function that calculates the Pearson correlation.

function corr = calc_pearson_corr(matrix)

mean_v = sum(matrix(:,1)) ./ size(matrix,1); % calculate the man of the nn row

mean_u = sum(matrix(:,2)) ./ size(matrix,1); % calculate the mean of the entry's row

num_den_values = []; % initialise a matrix to storee the values

for n_j = 1:size(matrix,1) % iterate through j values
    
    num = (matrix(n_j,2) - mean_u) * (matrix(n_j,1) - mean_v); % numerator 
    
    den_1 = (matrix(n_j,2) - mean_u).^2; % denominator 
    
    den_2 = (matrix(n_j,1) - mean_v).^2; % denominator 
    
    num_den_values = [num_den_values ; num den_1 den_2 ]; % store the values

end

corr_check = (sum(num_den_values(:,1))) ./ (sqrt(sum(num_den_values(:,2))) * sqrt(sum(num_den_values(:,3)))); % calculate the pearson correlation

if isnan(corr_check)
    
    corr = 0;
    
else
    
    corr = corr_check;
    
end

end
