% A function to predict the nonzero values in D_test using non-negative MF 
% and then measure the error (RMSE). Note that the 'nnmf' matlab function looks
% at all entries, and not just the rated entries as it should.

function rmse_mf = matrix_factorisation_nn(D_training,D_test,step,noise_factor,it_max,lambda)

[U,W] = nnmf(D_training,5);
V = W.';

% Form pred_test 
pred_test = form_pred_test(D_test,U,V);

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );  

end 
