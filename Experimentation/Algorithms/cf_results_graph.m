% Script to plot the final resultss of all the collaborative filtering algorithms.
clear all

x = [1 2 3 4 5];

y_rr = [0.8694 0.8988 0.7881 0.7863 0.7510]; 
y_ml = [2.0622 2.5301 2.0166 2.0381 2.9969]; 
y_ym = [3.0184 3.0402 2.1567 2.0466 3.3885]; 

err_rr = [0.0097 0.0519 0.0079 0.0135 0.0083];
err_ml = [0.0103  0.0112 0.0039 0.0106 0.0142];
err_ym = [0.0528 0.2302 0.2333 0.1385 0.1422];

hold on
rr = errorbar(x,y_rr,err_rr,'o');
ml = errorbar(x,y_ml,err_ml,'o');
ym = errorbar(x,y_ym,err_ym,'o');

xlabel('Collaborative Filtering Algorithm') % x axis is the item no.
ylabel('RMSE') % y axis is the frequency of the item no.
legend('Restaurant Rec','Movie Lens','Yahoo Music')