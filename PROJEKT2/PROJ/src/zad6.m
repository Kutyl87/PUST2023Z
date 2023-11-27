% addpath('C:\matlab2tikz\src');
% kk = 1000;
% yzad(1:260)=20;
% yzad(261:451)= 30.7;
% yzad(452:762) = 10.7;
% yzad(763:898) = 25.8;
% yzad(899:kk) = 35.9;
% t = linspace(1,kk,kk);
% z = get_sin_z(0.1,5,100);
% 
% % plot(z);
% % xlabel('k');
% % ylabel('wartość');
% % title('zakłócenia sinusoidalne');
% 
% %% nie uwzględnienie - zakłócenia od k = 100
% [u, y, e] = dmcfunction_no_zaklocenia(yzad, 120, 0, ...
%     [zeros(1, kk/2), z(1:kk/2)], 20, 5, 0.2, 3, -50, 50);
% figure
% hold on;
% plot(t,y,'LineWidth',1, 'LineStyle','-');
% sum(e.^2)
% 
% plot(t,yzad,'LineWidth',1, 'LineStyle','-');
% title('Charakterystyki y,y_{zad} bez mierzenia zakłócenia'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście", "Wartośc zadana",Location="northwest")
% matlab2tikz ('zad6_nie_uwzgl_k_100_period_5_yzad.tex' , 'showInfo' , false) 
% 
% %% nie uwzględnienie - zakłócenia od k = 0
% [u, y, e] = dmcfunction_no_zaklocenia(yzad, 120, 0, ...
%     [z(1:kk)], 20, 5, 0.2, 3, -50, 50);
% 
% figure
% hold on;
% plot(t,y,'LineWidth',1, 'LineStyle','-');
% sum(e.^2)
% 
% plot(t,yzad,'LineWidth',1, 'LineStyle','-');
% title('Charakterystyki y,y_{zad} bez mierzenia zakłócenia'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście", "Wartośc zadana",Location="northwest")
% matlab2tikz ('zad6_nie_uwzgl_k_0_period_5_yzad.tex' , 'showInfo' , false) 
% 
% 
% 
% %% uwzględniamy - zakłócenia od k = 0
% [u, y, e] = dmcfunction(yzad, 200, 200, ...
%     [z(1:kk)], 20, 5, 0.2, 3, -50, 50);
% figure
% hold on;
% 
% plot(t,y,'LineWidth',1, 'LineStyle','-');
% sum(e.^2)
% 
% plot(t,yzad,'LineWidth',1, 'LineStyle','-');
% title('Charakterystyki y,y_{zad} z mierzeniem zakłócenia'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście", "Wartośc zadana",Location="northwest")
% matlab2tikz ('zad6_uwzgl_k_0_period_5_yzad.tex' , 'showInfo' , false) 
% 
% figure
% plot(t,z(1:kk),'LineWidth',1, 'LineStyle','-');
% title('Przebieg zakłóceń'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% matlab2tikz ('zad6_zakl_k0_period_5_yzad.tex' , 'showInfo' , false) 
% 
% %% z mierzaniem zakłócenia od k = 100
% [u, y, e] = dmcfunction_no_zaklocenia(yzad, 120, 120, ...
%     [zeros(1, kk/2), z(1:kk/2)], 20, 5, 0.2, 3, -50, 50);
% figure
% hold on;
% plot(t,y,'LineWidth',1, 'LineStyle','-');
% sum(e.^2)
% 
% plot(t,yzad,'LineWidth',1, 'LineStyle','-');
% title('Charakterystyki y,y_{zad} z mierzeniem zakłóceń'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście", "Wartośc zadana",Location="northwest")
% matlab2tikz ('zad6_uwzgl_k_100_period_5_yzad.tex' , 'showInfo' , false) 
% 
% 
% 
% 

addpath('C:\matlab2tikz\src');
kk = 300;
yzad(1:50) = 0;
yzad(51:kk) = 1;
% yzad(1:260)=20;
% yzad(261:451)= 30.7;
% yzad(452:762) = 10.7;
% yzad(763:898) = 25.8;
% yzad(899:kk) = 35.9;    
t = linspace(1,kk,kk);
z = get_sin_z(0.1,15,30);

plot([zeros(1, 100), z(101:end)]);
xlabel('k');
ylabel('wartość');
title('zakłócenia sinusoidalne');
matlab2tikz ('zad6_zaklocenia_T_15.tex' , 'showInfo' , false) 

%% nie uwzględnienie - zakłócenia od k = 100
% [u1, y1, e1] = dmcfunction_no_zaklocenia(yzad, 120, 0, ...
%     [zeros(1, 100), z(100:kk-1)], 20, 5, 0.2, 3, -50, 50);
% 
% [u2, y2, e2] = dmcfunction(yzad, 200, 200, ...
%     [zeros(1, 100), z(100:kk-1)], 20, 5, 0.2, 3, -50, 50);
% figure
% hold on;
% plot(t,y1,'LineWidth',1, 'LineStyle','-');
% plot(t,y2,'LineWidth',1, 'LineStyle','-');
% 
% ee1 = sum(e1.^2);
% ee2 = sum(e2.^2);
% plot(t,yzad,'LineWidth',1, 'LineStyle','--');
% 
% title('Charakterystyki y,y_{zad} z zakłóceniami sinusoidalnymi T=15'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście bez uwzględnienia zakłóceń", "wyjście z uwzględnieniem zakłóceń", "Wartośc zadana",Location="southeast")
% matlab2tikz ('zad6_uwzg_i_nieuwzg_T_15.tex' , 'showInfo' , false) 

%% nie uwzględnienie - zakłócenia od k = 0
% [u, y, e] = dmcfunction_no_zaklocenia(yzad, 120, 0, ...
%     [z(1:kk)], 20, 5, 0.2, 3, -50, 50);
% 
% figure
% hold on;
% plot(t,y,'LineWidth',1, 'LineStyle','-');
% sum(e.^2)
% 
% plot(t,yzad,'LineWidth',1, 'LineStyle','-');
% title('Charakterystyki y,y_{zad} bez mierzenia zakłócenia'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście", "Wartośc zadana",Location="northwest")
% matlab2tikz ('zad6_nie_uwzgl_k_0_period_5_yzad.tex' , 'showInfo' , false) 



%% uwzględniamy - zakłócenia od k = 0
% [u, y, e] = dmcfunction(yzad, 200, 200, ...
%     [z(1:kk)], 20, 5, 0.2, 3, -50, 50);
% figure
% hold on;
% 
% plot(t,y,'LineWidth',1, 'LineStyle','-');
% sum(e.^2)
% 
% plot(t,yzad,'LineWidth',1, 'LineStyle','-');
% title('Charakterystyki y,y_{zad} z mierzeniem zakłócenia'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście", "Wartośc zadana",Location="northwest")
% matlab2tikz ('zad6_uwzgl_k_0_period_5_yzad.tex' , 'showInfo' , false) 
% 
% figure
% plot(t,z(1:kk),'LineWidth',1, 'LineStyle','-');
% title('Przebieg zakłóceń'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% matlab2tikz ('zad6_zakl_k0_period_5_yzad.tex' , 'showInfo' , false) 

%% z mierzaniem zakłócenia od k = 100
% [u, y, e] = dmcfunction_no_zaklocenia(yzad, 120, 120, ...
%     [zeros(1, kk/2), z(1:kk/2)], 20, 5, 0.2, 3, -50, 50);
% figure
% hold on;
% plot(t,y,'LineWidth',1, 'LineStyle','-');
% sum(e.^2)
% 
% plot(t,yzad,'LineWidth',1, 'LineStyle','-');
% title('Charakterystyki y,y_{zad} z mierzeniem zakłóceń'); 
% xlabel('k - number próbki');
% ylabel('Wartość')
% legend("wyjście", "Wartośc zadana",Location="northwest")
% matlab2tikz ('zad6_uwzgl_k_100_period_5_yzad.tex' , 'showInfo' , false) 




