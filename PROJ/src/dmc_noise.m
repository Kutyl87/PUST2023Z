
% matlab2tikz ('gaussiannoise.tex' , 'showInfo' , false)

kk = 1000;
    yzad(1:260)=20;
    yzad(261:451)= 30.7;
    yzad(452:762) = 10.7;
    yzad(763:898) = 25.8;
    yzad(899:kk) = 35.9;
z = [zeros(1, kk/2), ones(1, kk/2)];
[u, y, e, z_noised] = dmc_function_noised(yzad, 120, 50,z, 60, 60, 1, 3, -30, 30);
t = linspace(1,kk,kk);
figure;
stairs(t,u,'LineWidth',1.5, Color='r');
title('u - sterowanie'); 
xlabel('k - number próbki');
ylabel("Wartość sterowania")
matlab2tikz ('zad7_u_3.tex' , 'showInfo' , false)
figure;
subplot(2,1,1)
stairs(t,y,'LineWidth',1.5); 
hold on;
stairs(t,yzad,'LineWidth',1, 'LineStyle','--');
title('Charakterystyki y,y_{zad}'); 
xlabel('k - number próbki');
ylabel('Wartość')
legend("Wartość na wyjściu y", "Wartość zadana y_{zad}",Location="northwest")
subplot(2,1,2)
stairs(t,z,'LineWidth',1.5); 
xlabel('k - number próbki');
ylabel('Wartość')
title('Charakterystyka zakłócenia');
matlab2tikz ('zad7_y_3.tex' , 'showInfo' , false)
figure
stairs(t,z_noised,'LineWidth',1.5); 
xlabel('k - number próbki');
ylabel('Wartość')
matlab2tikz ('zad7_znoised_3.tex' , 'showInfo' , false)