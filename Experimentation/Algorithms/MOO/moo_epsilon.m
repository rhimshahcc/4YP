% A function to create a final ranking using MOO. 

function output_ranking = moo_epsilon(user_ranking,vendor_ranking,business_ranking)

max_target_error = 40; % max error for termination i.e. the convergence criterion

new_ranking = user_ranking; % fix the user ranking as the starting point

actual_target_error = ranking_error(business_ranking,new_ranking); % initial error between the two rankings

while actual_target_error > max_target_error
    
    new_random_ranking = randperm(130) % user_ranking --> (tends to) business_ranking, to reduce the error 
    
    
    combined_ranking = 
    
    actual_target_error = ranking_error(business_ranking,new_ranking) % new error between the two rankings
    
end

new_ranking 


% adding in vendor fairness
% optimise for the user and business objectives, form a new ranking



% select the first item with a '1' and add that as its ranking 
% select the first item with a '2' and add that as its ranking 
% sselect the first item with a '3' and add that as its ranking 
% all the remaining items have a rank '4'
% output the final ranking list

end 
