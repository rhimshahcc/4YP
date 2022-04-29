% A function to calculate the next value of U and V.

function [U,V,Y] = calc_next_U_V_svd(rank_k,i,j,step,U,V,Y,E,lambda,I)

I_i = nnz(I); % number of nonzero values in row i

[a,b,c] = find(I_i.');
nonzero_I = [b a c]; % matrix containing all the nonzero values in I and their position, [row col value]

for q = 1:rank_k % iterate, turn this into a function
           
    u_entry = U(i,q); % current u entry
    v_entry = V(j,q); % current v entry   
    error_entry = E(i,j); % error entry
    
    y_entries = []; % initialise y_entries
    
    for n_h = 1:size(nonzero_I,1) % iterate over h to calculate y_entry & y_entries
        
        h = nonzero_I(n_h,2); % col position of nonzero I_i values i.e. h
        
        y_entry = Y(h,q); % current y entry
        y_entries = [ y_entries ; y_entry ]; % vector of y entries for a specified q
        
        y_next_entry = y_entry + (step * error_entry * v_entry)./sqrt(I_i) - (step * lambda * y_entry); % calculate the next y entry
        Y(h,q) = y_next_entry; % assign new y entry to Y_next
        
    end

    u_next_entry = u_entry + (step * error_entry * v_entry) - (step * lambda * u_entry); % calculate the next u entry
    U(i,q) = u_next_entry; % assign new u entry to U_next

    v_next_entry = v_entry + (step * error_entry * (u_entry + sum(y_entries)./sqrt(I_i) )) - (step * lambda * v_entry); % calculate the next v entry
    V(j,q) = v_next_entry; % assign new v entry to V_next
                
end

end 
