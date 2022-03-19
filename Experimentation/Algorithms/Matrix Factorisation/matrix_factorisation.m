% A function to predict the nonzero values in D_test using SVD++ 
% and then measure the error (RMSE).

function rmse_mf = matrix_factorisation(D_training,D_test,step,noise_factor,converge_crit)

[i,j,v] = find(D_training);
s_D_training = [i j v]; % matrix containing all the nonzero values and their position, set s, [row col value]

rank_k = noise_factor * rank(D_training); % calculate the dimension of the latent factors

% Initialise U & V
U = ones(size(D_training,1),rank_k);
V = ones(size(D_training,2),rank_k);

while size(s_D_training) > 0
    
    E = D_training - (U*V.');
    
    for n_s = 1:size(s_D_training)
        
        i = s_D_training(n_s,1);
        j = s_D_training(n_s,2);
        
        U_next = U;
        V_next = V;
        
        for q = 1:rank_k
            
            u_entry = U(i,j);
            v_entry = V(i,j);
            
            u_next_entry = calc_next_u(u_entry,i,q,E,V,step);
            U_next(i,q) = u_next_entry;
            
            v_next_entry = calc_next_v(v_entry,j,q,E,U,step);
            V_next(j,q) = v_next_entry;
            
        end
        
    end
    
    U = U_next;
    V = V_next;
    E = D_training - (U*V.'); % new errr
    
    % Update s_D_training to contain only errors that do not meet the convergence criterion
    [f,p] = find(E<converge_crit); % find values in E that are < converge_crit
    
    t = diag(E(f,p)); % vector of errors that are still less than
    s_D_training = [f p t]; % update s_D_training
    
end


% form pred_test by selecting all the values from D_test
[i,j,v] = find(D_test);
nonzero_D_test = [i j v]; % matrix containing all the nonzero values and their position, [row col value]

pred_test = 

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );  

end 
