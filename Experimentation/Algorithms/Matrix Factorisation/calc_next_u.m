% A function to calculate the next value of u.

function u_next_entry = calc_next_u(u_entry,i,q,E,V,step)

error_vect = []; % initialise an empty error vector
v_vect = []; % initilaise an empty v vector

for j = 1:size(V,1) % iterate across j
    
    error_vect = [ error_vect ; E(i,j)]; % vector of error values
    v_vect = [ v_vect ; V(j,q) ]; % vector of v values
    
end

sum_vect = error_vect .* v_vect; % vector of each error value x v value, across j

u_next_entry = u_entry + step*sum(sum_vect); % calculate the next u entry

end 
