% A function to predict the nonzero values in D_test using stochastic GD 
% and then measure the error (RMSE).

function rmse_mf = matrix_factorisation_un_stochastic(D_training,D_test,step,noise_factor,converge_crit,it_max)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]

rank_k = noise_factor * rank(D_training); % calculate the dimension of the latent factors
rank_k = round(rank_k); % round
%rank_k = 8;

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
    
    E = D_training - (U*V.'); % current error
    
    for n_s = 1:size(s_D_training,1) % iterate on the error values that haven't met the convergence criterion
        
        i = s_D_training(n_s,1); % row position
        j = s_D_training(n_s,2); % col position
        
        U_next = U; % initialise U_next
        V_next = V; % initialise V_next
        
        for q = 1:rank_k % iterate
            
            u_entry = U(i,q); % current u entry
            v_entry = V(j,q); % current v entry   
            error_entry = E(i,j); % error entry
            
            u_next_entry = u_entry + (step * error_entry * v_entry); % calculate the next u entry
            U_next(i,q) = u_next_entry; % assign new u entry to U_next
            
            v_next_entry = v_entry + (step * error_entry * u_entry); % calculate the next v entry
            V_next(j,q) = v_next_entry; % assign new v entry to V_next
            
        end
        
    end
    
    U = U_next; % update U, now that the iterations have finished
    V = V_next; % update V, now that the iterations have finished

    % Form pred_test 
    pred_test = form_pred_test(D_test,U,V);

    % RMSE
    rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );
    
    it_rmse = [it_rmse ; it rmse_mf]; % iteration number and correpsonding rmse
    
    completion = (it / it_max) * 100 % percentage completion
    
end

rank_k

plot(it_rmse(:,1),it_rmse(:,2)) % plot the convergence

end 
