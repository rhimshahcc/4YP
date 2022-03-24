% A function to calculate the next value of v.

function v_next_entry = calc_next_v(v_entry,j,q,E,U,step)

error_vect = [];
v_vect = [];

for i = 1:size(U,1)
    
    error_vect = [ error_vect ; E(i,j)];
    v_vect = [ v_vect ; U(i,q) ];
    
end

sum_vect = error_vect .* v_vect;

v_next_entry = v_entry + step*sum(sum_vect);

end 
