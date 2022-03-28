% A function to calculate the next value of U and V.

function [U_next,V_next] = calc_next_U_V_svd(rank_k,i,j,step,U,V,E,lambda)
        
U_next = U; % initialise U_next
V_next = V; % initialise V_next

for q = 1:rank_k % iterate, turn this into a function
           
    u_entry = U(i,q); % current u entry
    v_entry = V(j,q); % current v entry   
    error_entry = E(i,j); % error entry

    u_next_entry = u_entry + (step * error_entry * v_entry) - (step * lambda * u_entry); % calculate the next u entry
    U_next(i,q) = u_next_entry; % assign new u entry to U_next

    v_next_entry = v_entry + (step * error_entry * (u_entry + )) - (step * lambda * v_entry); % calculate the next v entry
    V_next(j,q) = v_next_entry; % assign new v entry to V_next
    
    y_next_entry = v_entry + (step * error_entry * u_entry); % calculate the next y entry
    Y_next(h,q) = Y_next_entry; % assign new y entry to Y_next
            
end

end 
