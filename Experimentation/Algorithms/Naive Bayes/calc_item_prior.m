% A function to calculate the prior probability (item-based)

function item_prior = calc_item_prior(col_pos,D_training,n_item_val)

col = D_training(:,col_pos); % extract the entry's col

col_ratings_value_count = sum(col(:) == n_item_val); % count the frequency of n_item_val in the col

col_ratings_count = nnz(col); % count the total number of nonzero entries in the col

item_prior = col_ratings_value_count ./ col_ratings_count; % divide to get the prior

end