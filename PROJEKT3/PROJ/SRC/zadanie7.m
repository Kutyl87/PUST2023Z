%% Trzy regulatory
% Kp = [1.25, 0.23, 0.065];
% Ti = [0.7, 2.4, 3.2];
% Td = [1.2, 0.8, 0.1];

%% Dwa regulatory
% Kp = [1.25, 0.065];
% Ti = [0.7, 3.2];
% Td = [1.2, 0.1];

%% Cztery regulatory
Kp = [1.25, 0.3, 0.18, 0.065];
Ti = [0.7, 2.5, 3, 3.2];
Td = [1.2, 0.7, 0.8, 0.1];

%% Pięć regulatorów
Kp = [1.25, 0.3, 0.23, 0.18, 0.065];
Ti = [0.7, 2.5, 2.4, 3, 3.2];
Td = [1.2, 0.7, 0.8, 0.8, 0.1];


liczba_reg = 5;

yzad(1:50) = 0;
yzad(51:300) = -0.15;
yzad(301:450) = 5;
yzad(451:650) = 0.2;
yzad(651:800) = -0.1;
yzad(801:sim_end) = 0.9;

[y, u, error] = fuzzy_pid(liczba_reg, Kp, Ti, Td, @dummy_membership_trap_5, yzad);
figure
plot(y)
hold on
stairs(yzad)
hold off
title(sprintfc('Rozmyty regulator PID z %d regulatorami lokalnymi', liczba_reg))
xlabel('k')
ylabel('Wyjście')
legend(["Wyjście", "Wartość zadana"], "Location","northeast")
matlab2tikz (char(sprintfc('zad_7_pid_reg_lok_%d.tex', liczba_reg)) , 'showInfo' , false, 'standalone', true)

function w = dummy_membership_trap_2(point)
    w = trapezoidal_membership_function(point, 2, [[-2, -1, -0.1, 0.3]; [-0.1, 0.3, 1, 2]]);
end

function w = dummy_membership_trap_3(point)
    w = trapezoidal_membership_function(point, 3, [[-2, -1, -0.25, -0.05]; [-0.25, -0.05, 0.2, 0.4]; [0.2, 0.4, 1, 2]]);
end

function w = dummy_membership_trap_4(point)
    w = trapezoidal_membership_function(point, 4, [[-2, -1, -0.3, -0.1]; [-0.3, -0.1, 0, 0.2]; [0., 0.2, 0.2, 0.4]; [0.2, 0.4, 1, 2]]);
end

function w = dummy_membership_trap_5(point)
    w = trapezoidal_membership_function(point, 5, [[-2, -1, -0.3, -0.1]; [-0.3, -0.1, -0.1, 0.1]; [-0.1, 0.1, 0.1, 0.2]; [0.1, 0.2, 0.2, 0.4]; [0.2, 0.4, 1, 2]]);
end

function w = dummy_membership_2(point)
    w = bell_membership_function(point, 2, [[-1, 0.88, 10]; [1, 1.12, 10]]);
end

function w = dummy_membership_3(point)
    w = bell_membership_function(point, 3, [[-1.3, 1.1, 10]; [0.1, 0.3, 3];[1.3, 0.9, 7]]);
end

function w = dummy_membership_4(point)
    w = bell_membership_function(point, 4, [[-1.175, 0.9, 10]; [-0.105, 0.175, 4]; [0.285, 0.215, 4];[1.3, 0.8, 7]]);
end

function w = dummy_membership_5(point)
    w = bell_membership_function(point, 5, [[-1.2, 0.9, 9]; [-0.225, 0.075, 4]; [-0.05, 0.1, 4]; [0.125, 0.075, 4];[1, 0.8, 7]]);
end