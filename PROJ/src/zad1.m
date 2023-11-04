
sim_end = 400;
y_step = zeros(1, sim_end+1);
u = ones(1, sim_end+1)*2;
z = ones(1, sim_end+1);
u(1) = 0;
z(1) = 0;
for i=2:sim_end+1
    y_step(i) = symulacja_obiektu4y_p2(u(max(1, i-6)), u(max(1, i-7)),z(max(1,i-2)),z(max(1,i-3)) ,y_step(max(1, i-1)), y_step(max(1, i-2)));
end
plot(y_step)
% ylim([0, 0.9])
% xlim([0, sim_end])
title('Sprawdzenie wartości punktu pracy')
xlabel('k')
ylabel('Wyjście')
matlab2tikz ('test_punktu_pracy.tex' , 'showInfo' , false) 