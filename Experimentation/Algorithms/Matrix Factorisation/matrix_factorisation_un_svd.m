% A function to predict the nonzero values in D_test using SVD++
% and then measure the error (RMSE).

function rmse_mf = matrix_factorisation_un_svd(D_training,D_test,step,noise_factor,it_max,lambda)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]

rank_k = noise_factor * rank(D_training); % calculate the dimension of the latent factors
rank_k = round(rank_k); % round
rank_k = 2

% Initialise U & V
U = rand(size(D_training,1),rank_k);
V = rand(size(D_training,2),rank_k);
Y = rand(size(D_training,2),rank_k);

% Calculate F & I_i
F = calc_F(s_D_training,D_training);

% Form pred_test 
pred_test = form_pred_test_svd(D_test,U,V,Y,F);

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ))

% Plot convergence 
it_rmse = [0 rmse_mf];

for it = 1:it_max % iterate whilst there are still error values that haven't met the convergence criterion
    
    E = D_training - (U + F*Y)*V.'; % current error across all entries
    
    for n_s = 1:size(s_D_training,1) % iterate on the error values that haven't met the convergence criterion
        
        i = s_D_training(n_s,1); % row position
        j = s_D_training(n_s,2); % col position
        
        I = D_training(i,:); % extract the ith row from D_training
        
        [U_next,V_next,Y_next] = calc_next_U_V_svd(rank_k,i,j,step,U,V,Y,E,lambda,I); % calculate U_next, V_next and Y_next
        
    end
    
    U = U_next; % update U, now that the iterations have finished
    V = V_next; % update V, now that the iterations have finished
    Y = Y_next; % update Y, now that the iterations have finished

    % Form pred_test 
    pred_test = form_pred_test_svd(D_test,U,V,Y,F);

    % RMSE
    rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ));
    
    it_rmse = [it_rmse ; it rmse_mf]; % iteration number and correpsonding rmse
    
    completion = (it / it_max) * 100 % percentage completion
    
end

rank_k

plot(it_rmse(:,1),it_rmse(:,2)) % plot the convergence

end 
