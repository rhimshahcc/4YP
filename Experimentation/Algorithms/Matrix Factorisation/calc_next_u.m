% A function to calculate the next value of u.

function u_next_entry = calc_next_u(u_entry,i,q,E,V,step)

error_vect = [];
v_vect = [];

for j = 1:size(V,1)
    
    error_vect = [ error_vect ; E(i,j)];
    v_vect = [ v_vect ; V(j,q) ];
    
end

sum_vect = error_vect .* v_vect;

u_next_entry = u_entry + step*sum(sum_vect);

end 
