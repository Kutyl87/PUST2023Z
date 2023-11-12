us = [-2:0.05:2];
y_u = [];
figure
hold on
for i = 1:size(us, 2)
    output = step_simulation(us(i), 0, 200);
    y_u(i) = output(end);
end
plot( us, y_u);
title('Charakterystyka statyczna U')
xlabel('Sterowanie U')
ylabel('Wyjście')
matlab2tikz ('zad2_stat_u.tex' , 'showInfo' , false) 
% 
zs = [-2:0.05:2];
y_z = [];
figure
hold on
for i = 1:size(zs, 2)
    output = step_simulation(0, zs(i), 200);
    y_z(i) = output(end);
end
plot( us, y_z);
title('Charakterystyka statyczna Z')
xlabel('Zakłócenie Z')
ylabel('Wyjście')
matlab2tikz ('zad2_stat_z.tex' , 'showInfo' , false) 

figure 
y_u_z = [];
for i = 1:size(zs,2)
    for j = 1:size(us, 2)
    output = step_simulation(us(j), zs(i), 150);
    y_u_z(i, j) = output(end);
    end
end
hSurface  = surf( us, zs, y_u_z);
set(hSurface,'FaceColor',[0 0.4470 0.7410],'FaceAlpha',1);

title('Charakterystyka statyczna obiektu')
xlabel('Sterowanie U')
ylabel('Zakłócenie Z')
zlabel('Wyjście')
matlab2tikz ('zad2_stat_u_z.tex' , 'showInfo' , false) 
