% A function to create a user ranking user row. 

function user_ranking = user_rank(pred_user_row)
 
unordered_ranking = [1:size(pred_user_row,2) ; pred_user_row].'; % assign an item no. to each item

ordered_ranking = sortrows(unordered_ranking,2,'descend'); % sort the list by the value i.e. the 2nd col

user_ranking = [1:size(pred_user_row,2) ; ordered_ranking(:,1).'].'; % generate the final ranking list, [ranking item]

end 
