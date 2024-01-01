clear all;
nu = 4;
ny = 3;
%% Parametry PID
Tp = 0.5; % okres próbkowania
Kp = [1.7, 1.7, 2];
Ti = [10, 10, 12];
Td = [0.5, 0.5, 0.3];
r0 = zeros(1, 3);
r1 = zeros(1, 3);
r2 = zeros(1, 3);

for i = 1:3
    r2(i) = Kp(i)*Td(i)/Tp;
    r1(i) = Kp(i)*((Tp/(2*Ti(i))) -2 *(Td(i)/Tp) -1);
    r0(i) = Kp(i)*(1+(Tp/(2*Ti(i))) + (Td(i)/Tp));
end

%% Wartość zadana
sim_end = 1000;
yzad = zeros(ny, sim_end);
yzad(1,51:end) = ones(1, sim_end-50);
yzad(1,301:end) = ones(1, sim_end-300)*3;
yzad(1,701:end) = ones(1, sim_end-700)*2;
yzad(2,201:end) = ones(1, sim_end-200);
yzad(2,601:end) = ones(1, sim_end-600)*-0.5;
yzad(3,401:end) = ones(1, sim_end-400);
yzad(3,801:end) = ones(1, sim_end-800)*1.5;

%% Pętla regulatorów
pid_to_u = [1,1,1,0]; % lista z trzema 1 i jednym 0. [1,1,0,1] oznacza, że PIDy są podłączone do 1, 2, 4 wejść. Wejście 3 - nieobsłużone
current_i = 1;
Y = zeros(ny, sim_end);
U = zeros(nu, sim_end);
e = zeros(ny, sim_end);
for k = 3:sim_end
    [Y(1, k), Y(2, k),Y(3, k)] = symulacja_obiektu4y_p4( ...
        U(1, (max(1, k-1))), U(1, (max(1, k-2))), U(1, (max(1, k-3))), U(1, (max(1, k-4))), ...
        U(2, (max(1, k-1))), U(2, (max(1, k-2))), U(2, (max(1, k-3))), U(2, (max(1, k-4))), ...
        U(3, (max(1, k-1))), U(3, (max(1, k-2))), U(3, (max(1, k-3))), U(3, (max(1, k-4))), ...
        U(4, (max(1, k-1))), U(4, (max(1, k-2))), U(4, (max(1, k-3))), U(4, (max(1, k-4))), ...
        Y(1, (max(1,k-1))), Y(1, (max(1, k-2))), Y(1, (max(1, k-3))), Y(1, max(1,k-4)), ...
        Y(2, (max(1,k-1))), Y(2, (max(1, k-2))), Y(2, (max(1, k-3))), Y(2, max(1,k-4)), ...
        Y(3, (max(1,k-1))), Y(3, (max(1, k-2))), Y(3, (max(1, k-3))), Y(3, max(1,k-4)));
    
    e(:, k) = yzad(:,k) - Y(:,k);
    for i = 1:4
        if pid_to_u(i) == 1
            U(i, k) = r2(current_i)*e(current_i, k-2)+r1(current_i)*e(current_i, k-1)+ ...
                r0(current_i)*e(current_i, k)+U(i, k-1);

            current_i = current_i + 1;
        end
    end
    current_i = 1;
end
 
%% Wykresy
figure
locations = {'southeast','northeast', 'northeast'};
sgtitle({sprintf("Algorytm PID"), sprintf("Błąd = %.4f", sum(sum(e.^2)))})
for i=1:ny
    subplot(2, 2, i)
    ylim([-1, 3.5])
    title("Wyjście "+string(i))
    hold on
    plot(Y(i, :))
    stairs(yzad(i, :))
    legend(["Wyjście", "Warość zadana"], 'Location', locations(i))
end
subplot(2, 2, 4)
title("Sterowanie")
for i=1:nu
    hold on
    stairs(U(i, :))
end
ylim([-2, 6])

legend(["U_1", "U_2", "U_3","U_4"],'NumColumns',2, 'FontSize',7, 'Location', 'north')
% plot(yzad(1, :))

% matlab2tikz (sprintf('zad_4_dmc_fmincon_5_popr.tex') , 'showInfo' , false, 'standalone', true)

sum(sum(e.^2))
