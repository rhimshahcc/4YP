% A function to take transform the original list of user ratings into a ratings matrix.

function [ratings_matrix] = make_ratings_matrix(input_dataset, dataset_type)

% turn the 1st column of the dataset into a column vector
c1 = input_dataset(:,1);

% turn the 2nd column of the dataset into a column vector
c2 = input_dataset(:,2);

% turn the 3rd column of the dataset into a column vector

if dataset_type == 3;
        c3 = input_dataset(:,3) * 2;
        
    elseif dataset_type == 2;
        c3 = (input_dataset(:,3) ./ 10) + 1; 
        
    elseif dataset_type == 1; 
        c3 = input_dataset(:,3) + 1;
        
    else
        c3 = input_dataset(:,3);
        
end


UserID = categorical(c1); % take the 1st column from the matrix, D(1,~)
ItemID = categorical(c2);

%Formulation of the user vs item ratings matrix
ratings_matrix = crosstab(UserID,ItemID);
ratings_matrix(ratings_matrix==1) = c3;

end

