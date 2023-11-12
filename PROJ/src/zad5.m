figure
D_Z = [70, 50, 40, 20, 10];
kk = 200;
t = linspace(1,kk,kk);
hold on
for i = 1:5
    [u, y, e] = dmcfunction([zeros(1, kk/4), ones(1, 3*kk/4)], 120, D_Z(i), [zeros(1, kk/2), ones(1, kk/2)], 20, 5, 0.2, 3, -50, 50);
    stairs(t,y,'LineWidth',1, 'LineStyle','--');
    sum(e.^2)
end
stairs(t,[zeros(1, kk/4), ones(1, 3*kk/4)],'LineWidth',1, 'LineStyle','--');
title('Charakterystyki y,y_{zad}'); 
xlabel('k - number próbki');
ylabel('Wartość')
legend("Wartość na wyjściu y dla D_z = 70", "Wartość na wyjściu y dla D_z = 50", "Wartość na wyjściu y dla D_z = 40", "Wartość na wyjściu y dla D_z = 20", "Wartość na wyjściu y dla D_z = 10", "Wartośc zadana",Location="northwest")
matlab2tikz ('zad5DMC_y_DZ.tex' , 'showInfo' , false)

function error = calculate_square_error(y_zad, y_wy)
error = sum((y_zad-y_wy).^2);
end