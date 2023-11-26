sendControls([1], ... send for these elements
                 [50]);

yzad(1:181)=Ypp;
yzad(182:551)=38;
yzad(552:951) = 34;
yzad(952:kk) = Ypp;

dmcfunction(yzad, 700, 700, zeros(1, kk), 500, 500, 1, 30, 0, 90);


function [u, y, e] = dmcfunction(yzad, D,D_z, z, N, Nu, lambda, deltaumax, Umin, Umax)
    % Inicjalizacja wektorów
    s_u = get_s(770);
    s_z = get_zs(0, 0, 770);
    kk = length(yzad);
    u = zeros(1, kk);
    y = zeros(1, kk);
    e = zeros(1, kk);
    M = zeros(N,Nu);
    Mp = zeros(N,D-1);
    Mp_z = zeros(N,D_z-1);
    % Macierz M
    for i = 1:N
        for j = 1:Nu
            if (i-j+1) > 0
                M(i,j) = s_u(i-j+1);
            end
        end
    end

    % Macierz Mpu
    for i = 1:N
        for j = 1:D-1
            Mp(i,j) = s_u(min(i+j,D)) - s_u(j);
        end
    end
    for i = 1:N
        for j = 1:D_z-1
            Mp_z(i,j) = s_z(min(i+j,D)) - s_z(j);
        end
    end
    % Wyznaczenie K i dobranie parametrów kary
    Gamma = eye(N, N);
    Alpha = eye(Nu, Nu) * lambda;
    K = inv(M' * Gamma * M + Alpha) * M' * Gamma;

    % Inicjalizacja wektora du i współczynników równania różnicowego
    du = zeros(1, 12);
    % Główna pętla regulatora
    for k = 12:kk
        dUp = [];
        du_z = [];
        y(k) = readMeasurements(1);
        e(k) = yzad(k) - y(k);
        Yzadk = yzad(k) * ones(N, 1);
        Yk = y(k) * ones(N, 1);
        for i = 1:D-1
            dUp = [dUp; u(max(k-i, 1)) - u(max(k-i-1, 1))];
        end
        for i = 1:D_z-1
            du_z = [du_z; z(max(k-i, 1)) - z(max(k-i-1, 1))];
        end
        dU = K * (Yzadk - Yk - Mp * dUp - Mp_z*du_z);
        u(k) = dU(1) + u(k-1);

        % Skalowanie wartości u
        deltau = u(k) - u(k-1);
        u(k) = u(k-1) + min(abs(deltau), abs(deltaumax)) * sign(deltau);

        % Sprawdzenie czy U znajduje się w przedziale, ew. ścięcie
        u(k) = max(min(u(k), Umax), Umin);

        sendControlsToG1AndDisturbance(u(k), z(k));
        waitForNewIteration();

        refreshdata
        drawnow
        hold on;
        t = linspace(1,kk,kk);
        stairs(t, y)
        stairs(t,yzad,'LineWidth',1, 'LineStyle','--');
        title('Charakterystyki y,y_{zad}'); 
        xlabel('k - number próbki');
        ylabel('Wartość')
        legend("Wartość na wyjściu y", "Wartość zadana y_{zad}")
        hold off
        matlab2tikz ('zad5_dmc6.tex' , 'showInfo' , false)

        % Wprowadzenie zmian wartości zadanej
    end
end