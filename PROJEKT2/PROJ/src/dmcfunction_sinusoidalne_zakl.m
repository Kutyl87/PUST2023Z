function [u, y, e] = dmcfunction_sinusoidalne_zakl(yzad, D,D_z, z, N, Nu, lambda,...
    deltaumax, Umin, Umax)
    % Inicjalizacja wektorów
    s_u = get_s_u(0, 0, 300);
    s_z = get_s_z(0, 0, 300);
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
    z_sin = z + get_sin_z(0.1,1,kk/10-0.1);
    % Główna pętla regulatora
    for k = 12:kk
        dUp = [];
        du_z = [];
        y(k) = symulacja_obiektu4y_p2(u(k-6), u(k-7), z(k-2), z(k-3), y(k-1), y(k-2));
        e(k) = yzad(k) - y(k);
        Yzadk = yzad(k) * ones(N, 1);
        Yk = y(k) * ones(N, 1);
        for i = 1:D-1
            dUp = [dUp; u(max(k-i, 1)) - u(max(k-i-1, 1))];
        end
        for i = 1:D_z-1
            du_z = [du_z; z_sin(max(k-i, 1)) - z(max(k-i-1, 1))];
        end
        dU = K * (Yzadk - Yk - Mp * dUp - Mp_z*du_z);
        u(k) = dU(1) + u(k-1);

        % Skalowanie wartości u
        deltau = u(k) - u(k-1);
        u(k) = u(k-1) + min(abs(deltau), abs(deltaumax)) * sign(deltau);

        % Sprawdzenie czy U znajduje się w przedziale, ew. ścięcie
        u(k) = max(min(u(k), Umax), Umin);

        % Wprowadzenie zmian wartości zadanej
    end
end