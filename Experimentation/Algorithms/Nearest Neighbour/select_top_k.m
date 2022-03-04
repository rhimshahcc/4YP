% A function that orders the correlations and then selects the top k%.

function top_k_corr_matrix = select_top_k(corr_matrix,k)

k_rows = size(corr_matrix,1) * (k./100); % turn the k% to the top-k rows
k_rows = round(k_rows); % round in case k_rows is not an integer

if size(corr_matrix,1) >= 1
    
    corr_matrix = sortrows(corr_matrix,2,'descend'); % sort the correlation matrix into descending correlation values
    top_k_corr_matrix = corr_matrix(1:k_rows,1:2); % select the top-k rows from the sorted correlation matrix
    
else
    
    top_k_corr_matrix = corr_matrix;

end

end
