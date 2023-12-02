%% Pierwszy regulator PID
% Kp = 1.5;
% Ti = 0.9;
% Td = 1;
% Yzad(1:200) = -0.21;
% Yzad(201:400) = -0.17;
% 
% [y, u, e] = pid_reg(Kp, Ti, Td, Yzad, -1, -0.21);
% figure
% hold on
% plot(y)
% plot(Yzad)
% hold off
% figure
% plot(u)

%% Drugi regulator PID
Kp = 0.23;
Ti = 2.4;
Td = 0.7;
Yzad(1:200) = 0;
Yzad(201:400) = 0.5;

[y, u, e] = pid_reg(Kp, Ti, Td, Yzad, 0, 0);
figure
hold on
plot(y)
plot(Yzad)
hold off
figure
plot(u)

%% Trzeci regulator PID
% Kp = 0.06;
% Ti = 3;
% Td = 0.1;
% Yzad(1:200) = 3.5;
% Yzad(201:400) = 4.5;
% 
% [y, u, e] = pid_reg(Kp, Ti, Td, Yzad, 0.62, 3.5);
% figure
% hold on
% plot(y)
% stairs(Yzad)
% hold off
% figure
% plot(u)