figure
lambda = 1;
    deltaumax = 0.03;
    kk = 200;
%     yzad(1:260)=20;
%     yzad(261:451)= 30.7;
%     yzad(452:762) = 15;
%     yzad(763:898) = 28.8;
%     yzad(899:kk) = 35.9;
    yzad = zeros(1, 50);
    yzad(51: kk) = 1;
    t = linspace(1,kk,kk);
    lambdass = [120, 100, 0.2, 0.1, 0.01];
    Ns = [20, 15, 10, 5, 3];
hold on
for i = 1:5
    [u, y, e] = dmcfunction(yzad, 120, 70, zeros(1, kk), 20, Ns(i), 1, 3, -50, 50);
    stairs(t,y,'LineWidth',1, 'LineStyle','--');
    sum(e.^2)
end
stairs(t,yzad,'LineWidth',1, 'LineStyle','--');
title('Charakterystyki y,y_{zad}'); 
xlabel('k - number próbki');
ylabel('Wartość')
legend("Wartość na wyjściu y dla N_u = 20", "Wartość na wyjściu y dla N = 15", "Wartość na wyjściu y dla N = 10", "Wartość na wyjściu y dla N = 5", "Wartość na wyjściu y dla N = 3", "Wartość zadana y_{zad}",Location="southeast")
matlab2tikz ('zad4DMC_y_Nu1.tex' , 'showInfo' , false)
% N = 20 Nu = 5
