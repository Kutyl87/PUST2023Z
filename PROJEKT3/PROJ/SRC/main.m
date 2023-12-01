% trapezoidal_membership_function(0.5, 3, [[-2, -1, -0.5, 0]; [-1, -0.5, 0.5, 1]; [0, 0.5, 1, 2]])
% figure
% weights = [];
% x = [-1:0.05:1];
% for i=1:41
%     weights(i, :) = trapezoidal_membership_function(x(i), 3, [[-2, -1, -0.2, 0]; [-0.2, 0, 0.2, 0.4]; [0.2, 0.4, 1, 2]]);
% end
% 
% plot(x, weights)
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
x = [-1:0.05:1];
for i=1:41
    weights(i, :) = bell_membership_function(x(i), 3, [[-1.3, 1.1, 10]; [1.3, 0.9, 7]; [0.1, 0.3, 3]]);
end

plot(x, weights)