% A function to predict the nonzero values in D_test using SVD++ 
% and then measure the error (RMSE).

function rmse_mf = matrix_factorisation(D_training,D_test,step,noise_factor,converge_crit)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]
initial_size = size(s_D_training,1);

rank_k = noise_factor * rank(D_training); % calculate the dimension of the latent factors
rank_k = round(rank_k) % round
rank_k = 4

% Initialise U & V
U = rand(size(D_training,1),rank_k);
V = rand(size(D_training,2),rank_k);

while size(s_D_training,1) > 0 % iterate whilst there are still error values that haven't met the convergence criterion
    
    E = D_training - (U*V.'); % current error
    size(s_D_training,1);
    
    for n_s = 1:size(s_D_training,1) % iterate on the error values that haven't met the convergence criterion
        
        i = s_D_training(n_s,1); % row position
        j = s_D_training(n_s,2); % col position
        
        U_next = U; % initialise U_next
        V_next = V; % initialise V_next
        
        for q = 1:rank_k % iterate
            
            u_entry = U(i,q); % current u entry
            v_entry = V(j,q); % current v entry
            
            error_entry = E(i,j) % error entry
            
            u_next_entry = calc_next_u(u_entry,i,q,E,V,step) % calculate the next u entry
            U_next(i,q) = u_next_entry; % assign new u entry to U_next
            
            v_next_entry = calc_next_v(v_entry,j,q,E,U,step) % calculate the next v entry
            V_next(j,q) = v_next_entry; % assign new v entry to V_next
            
        end
        
    end
    
    U = U_next; % update U, now that iterations have finished
    V = V_next; % update V, now that iterations have finished
    E = D_training - (U*V.'); % new error
    
    % Update s_D_training to contain only errors that do not meet the convergence criterion
    [f,p] = find(E < converge_crit); % find values in E that are < converge_crit
    t_loc = E < converge_crit; % location of value in E that are < converge_crit
    t = E(t_loc); % vector of errors in E that are < converge_crit
    
    s_D_training = [f p t]; % update s_D_training
    
    new_size = size(s_D_training,1);
    completion = ( 1 - (new_size / initial_size)) * 100
    
end

% Form pred_test 
pred_test = form_pred_test(D_test,U,V);

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );  

end 
