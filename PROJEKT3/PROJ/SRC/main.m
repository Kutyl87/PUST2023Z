% trapezoidal_membership_function(0.5, 3, [[-2, -1, -0.5, 0]; [-1, -0.5, 0.5, 1]; [0, 0.5, 1, 2]])
% figure
% weights = [];
% x = [-1:0.05:1];
% for i=1:41
%     weights(i, :) = trapezoidal_membership_function(x(i), 3, [[-2, -1, -0.25, -0.05]; [-0.25, -0.05, 0.2, 0.4]; [0.2, 0.4, 1, 2]]);
% end
% 
% plot(x, weights)
% title('Trapezoidalna funcja przynależności')
% xlabel('Sterowanie')
% ylabel('Waga')
% matlab2tikz ('zad_5_trapez_3.tex' , 'showInfo' , false, 'standalone', true) 
% 
% 
% figure
% weights = [];
% x = [-1:0.05:1];
% for i=1:41
%     weights(i, :) = bell_membership_function(x(i), 2, [[-1, 1.1, 10]; [1, 0.9, 7]]);
% end
% 
% plot(x, weights)

figure
weights = [];
x = [-1:0.01:1];
for i=1:size(x, 2)
    weights(i, :) = bell_membership_function(x(i), 3, [[-1.3, 1.1, 10]; [0.1, 0.3, 3];[1.3, 0.9, 7]]);
end
plot(x, weights)
title('Dzwonowa funcja przynależności')
xlabel('Sterowanie')
ylabel('Waga')
matlab2tikz ('zad_5_dzwon_3.tex' , 'showInfo' , false, 'standalone', true) 