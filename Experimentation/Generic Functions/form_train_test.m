% A function to form the training and test datasets by merging the folds.

function [D_training,D_test] = form_train_test(D_split,split)

D_training = D_split{1};

if split > 2
    for n = 1:(split-2)
    
        D_training = D_training + D_split{n+1};
    
    end
end 

D_test = D_split{split};

end
