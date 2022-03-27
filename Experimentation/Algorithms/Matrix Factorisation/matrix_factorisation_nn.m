% A function to predict the nonzero values in D_test using SVD++ 
% and then measure the error (RMSE).

function rmse_mf = matrix_factorisation_nnmf(D_training,D_test)

[U,W] = nnmf(D_training,5);
V = W.';

% Form pred_test 
pred_test = form_pred_test(D_test,U,V);

% RMSE
rmse_mf = sqrt( sum( ((D_test - pred_test).^2) ./ nnz(pred_test), 'all' ) );  

end 
