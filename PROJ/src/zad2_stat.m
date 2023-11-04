us = [-2:0.01:2];
y_u = [];
figure
hold on
for i = 1:size(us, 2)
    output = step_simulation(us(i), 0, 200);
    y_u(i) = output(end);
end
plot( us, y_u);
title('Charakterystyka statyczna U')
xlabel('k - number próbki')
ylabel('Wyjście')
matlab2tikz ('zad2_stat_u.tex' , 'showInfo' , false) 

zs = [-2:0.01:2];
y_z = [];
figure
hold on
for i = 1:size(zs, 2)
    output = step_simulation(0, zs(i), 200);
    y_z(i) = output(end);
end
plot( us, y_z);
title('Charakterystyka statyczna Z')
xlabel('k - number próbki')
ylabel('Wyjście')
matlab2tikz ('zad2_stat_z.tex' , 'showInfo' , false) 