Ypp = 0;
Upp = 0;
sim_end = 49;
y_step = ones(1, sim_end+1)*12;
u = ones(1, sim_end+1)*Upp;
u(1) = 1;

for i=2:sim_end+1
    y_step(i) = symulacja_obiektu4y_p3(u(max(1, i-5)), u(max(1, i-6)), y_step(max(1, i-1)), y_step(max(1, i-2)));
end

stairs(y_step)
title('Sprawdzenie wartości punktu pracy')
xlabel('k')
ylabel('Wyjście')
matlab2tikz ('zad_1_test_punktu_pracy.tex' , 'showInfo' , false, 'standalone', true) 
