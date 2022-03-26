% A function to calculate the next value of v.

function v_next_entry = calc_next_v(v_entry,j,q,E,U,step)

error_vect = []; % initialise an empty error vector
u_vect = []; % initilaise an empty u vector

for i = 1:size(U,1) % iterate across i
    
    error_vect = [ error_vect ; E(i,j)]; % vector of error values
    u_vect = [ u_vect ; U(i,q) ]; % vector of u values
    
end

sum_vect = error_vect .* u_vect; % vector of each error value x u value, across i

v_next_entry = v_entry + step*sum(sum_vect); % calculate the next v entry

end 
