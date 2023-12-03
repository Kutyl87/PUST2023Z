trapezoidal_membership_function(0.5, 3, [[-2, 0, 40, 44.5]; [40, 44.5, 44.5, 48]; [44.5, 48, 80, 90]])
figure
weights = [];
x = [30:0.5:55];
for i=1:size(x, 2)
    weights(i, :) = trapezoidal_membership_function(x(i), 3, [[-2, 0, 40, 44.5]; [40, 44.5, 44.5, 47.5]; [44.5, 47.5, 80, 90]]);
end

plot(x, weights)