% A function to predict the nonzero values in D_test using stochastic GD 
% and then measure the error (RMSE).

function [rmse_mf,pred_test,it_rmse] = matrix_factorisation_un_stochastic(D_training,D_test,step,rank_k,lambda,conv_crit)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]

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
    
    it = it +1;
    
    random_rows = randperm(size(s_D_training,1)).'; % generate a list of random row numbers
    
    for n_s = 1:size(s_D_training,1) % iterate on the error values that haven't met the convergence criterion
        
        n_random = random_rows(n_s,1); % select the random row
        
        i = s_D_training(n_random,1); % row position
        j = s_D_training(n_random,2); % col position
        
        error_entry = D_training(i,j) - sum(U(i,:) .* V(j,:));
        
        for q = 1:rank_k % iterate
            
            u_entry = U(i,q); % current u entry
            v_entry = V(j,q); % current v entry
            
            u_next_entry = u_entry + (step * error_entry * v_entry); % calculate the next u entry
            U(i,q) = u_next_entry; % assign new u entry to U_next
            
            v_next_entry = v_entry + (step * error_entry * u_entry); % calculate the next v entry
            V(j,q) = v_next_entry; % assign new v entry to V_next
            
        end
        
    end 

    % Form pred_test 
    pred_test = form_pred_test(D_test,U,V);

    % RMSE
    rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );
    
    rmse_mf_diff = abs(rmse_mf - it_rmse(end,2)); % update the difference between the current rmse_mf and the last rmse_mf
    
    it_rmse = [it_rmse ; it rmse_mf]; % iteration number and correpsonding rmse
    
end

rank_k

it

rmse_change = abs((it_rmse(end,2) - it_rmse(1,2)) ./ it_rmse(1,2)) * 100

plot(it_rmse(:,1),it_rmse(:,2)) % plot the convergence

end 
