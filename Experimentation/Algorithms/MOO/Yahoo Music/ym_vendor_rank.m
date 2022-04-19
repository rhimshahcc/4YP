% A function to create a vendor ranking user row. 

function vendor_ranking = ym_vendor_rank(ratings_matrix)

long_tail = sum(ratings_matrix~=0); % row vector of the number of nonzero values in each column

unordered_ranking = [ 1:size(ratings_matrix,2) ; long_tail ].'; % unordered matrix of [item_no. long_tail]
ordered_ranking = sortrows(unordered_ranking,2,'ascend'); % ordered by the long_tail column

vendor_ranking = [ordered_ranking(:,2).' + 1 ; ordered_ranking(:,1).'].'; % generate the final ranking list, [ranking item_no.]

end 
