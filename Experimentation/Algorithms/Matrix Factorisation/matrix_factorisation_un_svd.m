% A function to predict the nonzero values in D_test using SVD++
% and then measure the error (RMSE).

function [rmse_mf,pred_test] = matrix_factorisation_un_svd(D_training,D_test,step,rank_k,lambda,conv_crit)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]

% Initialise U & V
U = rand(size(D_training,1),rank_k);
V = rand(size(D_training,2),rank_k);
Y = rand(size(D_training,2),rank_k);

% Calculate F & I_i
F = calc_F(s_D_training,D_training);

% Form pred_test 
pred_test = form_pred_test_svd(D_test,U,V,Y,F);

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ));

% Plot convergence 
it_rmse = [0 rmse_mf];

rmse_mf_diff = 5; % Difference between the rmse s
it = 0; % initialise iterations

while rmse_mf_diff > conv_crit  % iterate whilst there are still error values that haven't met the convergence criterion
    
    it = it +1
    
    E = D_training - (U + F*Y)*V.'; % current error across all entries
    
    random_rows = randperm(size(s_D_training,1)).'; % generate a list of random row numbers
    
    for n_s = 1:size(s_D_training,1) % iterate on the error values that haven't met the convergence criterion
        
        n_random = random_rows(n_s,1); % select the random row
        
        i = s_D_training(n_random,1); % row position
        j = s_D_training(n_random,2); % col position
        
        I = D_training(i,:); % extract the ith row from D_training
             
        [U,V,Y] = calc_next_U_V_svd(rank_k,i,j,step,U,V,Y,E,lambda,I); % calculate U_next, V_next and Y_next
        
    end

    % Form pred_test 
    pred_test = form_pred_test_svd(D_test,U,V,Y,F);

    % RMSE
    rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ))
    
    rmse_mf_diff = abs(rmse_mf - it_rmse(end,2)); % update the difference between the current rmse_mf and the last rmse_mf
    
    it_rmse = [it_rmse ; it rmse_mf]; % iteration number and correpsonding rmse
    
end

rank_k

rmse_change = abs((it_rmse(end,2) - it_rmse(1,2)) ./ it_rmse(1,2)) * 100

plot(it_rmse(:,1),it_rmse(:,2)) % plot the convergence

end 
