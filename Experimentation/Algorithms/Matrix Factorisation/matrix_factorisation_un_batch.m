% A function to predict the nonzero values in D_test using batch GD 
% and then measure the error (RMSE).

function rmse_mf = matrix_factorisation_un_batch(D_training,D_test,step,noise_factor,lambda,conv_crit)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]

rank_k = noise_factor * rank(D_training); % calculate the dimension of the latent factors
rank_k = round(rank_k); % round
rank_k = 25;

% Initialise U & V
U = rand(size(D_training,1),rank_k);
V = rand(size(D_training,2),rank_k);

% Form pred_test 
pred_test = form_pred_test(D_test,U,V);

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) ); 

% Plot convergence 
it_rmse = [0 rmse_mf];

rmse_mf_diff = 5; % Difference between the rmse s
it = 0; % initialise iterations

while rmse_mf_diff > conv_crit  % iterate whilst there are still error values that haven't met the convergence criterion
    
    it = it +1
    
    E = zeros(size(D_training));
    E_unfiltered = D_training - (U*V.'); % current error
    
    for n_E = 1:size(s_D_training) % iterate
    
        row_pos = s_D_training(n_E,1); % row position 
        col_pos = s_D_training(n_E,2); % col position

        E(row_pos,col_pos) = E_unfiltered(row_pos,col_pos); % extract the value from E_unfiltered and assign to E
    
    end
    
    U_next = U + (step*E*V); % calculate the next U
    V_next = V + (step*E.'*U); % calculate the next V
    
    U = U_next; % update U, now that iterations have finished
    V = V_next; % update V, now that iterations have finished
    
    % Form pred_test 
    pred_test = form_pred_test(D_test,U,V);

    % RMSE
    rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) ); 
    
    rmse_mf_diff = abs(rmse_mf - it_rmse(end,2)); % update the difference between the current rmse_mf and the last rmse_mf
    
    it_rmse = [it_rmse ; it rmse_mf]; % iteration number and correpsonding rmse
    
    %completion = (it / it_max) * 100; % percentage completion
    
end

rank_k

rmse_change = abs((it_rmse(end,2) - it_rmse(1,2)) ./ it_rmse(1,2)) * 100

initial_rmse = it_rmse(1,2)

plot(it_rmse(:,1),it_rmse(:,2))

end 
