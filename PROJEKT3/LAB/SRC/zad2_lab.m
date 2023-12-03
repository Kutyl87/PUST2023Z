Upp = 29;
Ypp = 34.9;
u = [20:10:80];
y = [31, 35.25, 39.9, 44.5, 46.75, 49.5, 52];
plot(u, y);
title('Charakterystyka statyczna')
xlabel('Sterowanie')
ylabel('Wyjście')
matlab2tikz ('zad2_stat.tex' , 'showInfo' , false, 'standalone', true)
