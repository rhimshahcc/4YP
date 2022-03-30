% A function to predict the nonzero values in D_test using batch GD 
% and then measure the error (RMSE).

function rmse_mf = matrix_factorisation_un_batch(D_training,D_test,step,noise_factor,it_max,lambda)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]

rank_k = noise_factor * rank(D_training); % calculate the dimension of the latent factors
rank_k = round(rank_k); % round
%rank_k = 2;

% Initialise U & V
U = rand(size(D_training,1),rank_k);
V = rand(size(D_training,2),rank_k);

% Form pred_test 
pred_test = form_pred_test(D_test,U,V);

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) ); 

% Plot convergence 
it_rmse = [0 rmse_mf];

for it = 1:it_max % iterate whilst there are still error values that haven't met the convergence criterion
    
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
    
    it_rmse = [it_rmse ; it rmse_mf]; % iteration number and correpsonding rmse
    
    completion = (it / it_max) * 100 % percentage completion
    
end

rank_k

plot(it_rmse(:,1),it_rmse(:,2))

end 
