us = [-1, -0.5, 0, 0.5, 1];
figure
hold on
for i = 1:5
    plot(step_simulation(us(i), 0, 200), 'DisplayName', 'U = ' + string(us(i)));
end

legend('Location', 'east');
title('Symulacja obiektu dla różnego sterowania U')
xlabel('k - number próbki')
ylabel('Wyjście')
matlab2tikz ('zad2_dyn_u.tex' , 'showInfo' , false) 

zs = [-1, -0.5, 0, 0.5, 1];
figure
hold on
for i = 1:5
    plot(step_simulation(0, zs(i), 100), 'DisplayName', 'Z = ' + string(zs(i)));
end

legend('Location', 'east');
title('Symulacja obiektu dla różnego zakłócenia Z')
xlabel('k - number próbki')
ylabel('Wyjście')
matlab2tikz ('zad2_dyn_z.tex' , 'showInfo' , false) 