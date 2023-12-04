%% Pierwszy regulator PID
% Kp = 1.25;
% Ti = 0.7;
% Td = 1.2;
% Yzad(1:200) = -0.21;
% Yzad(201:400) = -0.17;
% 
% [y, u, e] = pid_reg(Kp, Ti, Td, Yzad, -1, -0.21);
% figure
% hold on
% plot(y(101:end))
% plot(Yzad(101:end))
% hold off
% title('Pierwszy regulator lokalny')
% xlabel('k')
% ylabel('Wyjście')
% legend(["Wyjście", "Wartość zadana"], "Location","southeast")
% matlab2tikz ('zad_6_pid_lokalny1.tex' , 'showInfo' , false, 'standalone', true)
% figure
% plot(u)

%% Drugi regulator PID
% Kp = 0.23;
% Ti = 2.4;
% Td = 0.8;
% % Kp = 0.25;
% % Ti = 2.5;
% % Td = 0.8;
% Yzad(1:200) = 0;
% Yzad(201:400) = 0.5;
% 
% [y, u, e] = pid_reg(Kp, Ti, Td, Yzad, 0, 0);
% figure
% hold on
% plot(y(101:end))
% plot(Yzad(101:end))
% hold off
% title('Drugi regulator lokalny')
% xlabel('k')
% ylabel('Wyjście')
% legend(["Wyjście", "Wartość zadana"], "Location","southeast")
% matlab2tikz ('zad_6_pid_lokalny3.tex' , 'showInfo' , false, 'standalone', true)
% figure
% plot(u)

%% Trzeci regulator PID
% Kp = 0.065;
% Ti = 3.2;
% Td = 0.1;
% Yzad(1:200) = 3.5;
% Yzad(201:400) = 4.5;
% 
% [y, u, e] = pid_reg(Kp, Ti, Td, Yzad, 0.62, 3.5);
% figure
% e = e(150:end);
% sum(e.^2)
% hold on
% plot(y(101:end))
% plot(Yzad(101:end))
% hold off
% title('Trzeci regulator lokalny')
% xlabel('k')
% ylabel('Wyjście')
% legend(["Wyjście", "Wartość zadana"], "Location","southeast")
% matlab2tikz ('zad_6_pid_lokalny5.tex' , 'showInfo' , false, 'standalone', true)
% figure
% plot(u)

%% Czwarty regulator PID
% przedział -0.2, 0.2
% Kp = 0.3;
% Ti = 2.5;
% Td = 0.7;
% % Kp = 0.25;
% % Ti = 2.5;
% % Td = 0.8;
% Yzad(1:200) = 0;
% Yzad(201:400) = 0.4;
% 
% [y, u, e] = pid_reg(Kp, Ti, Td, Yzad, 0, 0);
% figure
% hold on
% plot(y(101:end))
% plot(Yzad(101:end))
% hold off
% title('Drugi regulator lokalny')
% xlabel('k')
% ylabel('Wyjście')
% legend(["Wyjście", "Wartość zadana"], "Location","southeast")
% matlab2tikz ('zad_6_pid_lokalny2.tex' , 'showInfo' , false, 'standalone', true)
% figure
% plot(u)

%% Piąty regulator PID
% przedizał 0.2 0.5
Kp = 0.18;
Ti = 3;
Td = 0.8;
% Kp = 0.25;
% Ti = 2.5;
% Td = 0.8;
Yzad(1:200) = 0.5;
Yzad(201:400) = 1.5;

[y, u, e] = pid_reg(Kp, Ti, Td, Yzad, 0.2, 0.42);
figure
hold on
plot(y(101:end))
plot(Yzad(101:end))
hold off
title('Drugi regulator lokalny')
xlabel('k')
ylabel('Wyjście')
legend(["Wyjście", "Wartość zadana"], "Location","southeast")
matlab2tikz ('zad_6_pid_lokalny4.tex' , 'showInfo' , false, 'standalone', true)
figure
plot(u)

%% FMINCON
a = fmincon(@pid_fuction, [1, 1, 1], [], [], [], [], [0, 0, 0], [100, 100, 10])

function e = pid_fuction(params)
Yzad(1:200) = 0.5;
Yzad(201:800) = 1.5;
[y, u, e] = pid_reg(params(1), params(2), params(3), Yzad, 0.2, 0.42);
e = e(150:end);
e = sum(e.^2);
end