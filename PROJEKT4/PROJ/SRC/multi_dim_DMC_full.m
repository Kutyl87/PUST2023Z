clear all;

s = get_s([0,0,0,0], [0,0,0], 200);
lambdas = [0.80 0.30  0.60 0.50];
gammas = [2.50    3.50    5];
nu = 4;
ny = 3;

sim_end = 1000;
yzad = zeros(ny, sim_end);
yzad(1,51:end) = ones(1, sim_end-50);
yzad(1,301:end) = ones(1, sim_end-300)*3;
yzad(1,701:end) = ones(1, sim_end-700)*2;
yzad(2,201:end) = ones(1, sim_end-200);
yzad(2,601:end) = ones(1, sim_end-600)*-0.5;
yzad(3,401:end) = ones(1, sim_end-400);
yzad(3,801:end) = ones(1, sim_end-800)*1.5;
N = 50;
Nu = 25;
D = 200;
M = {};
Mp = {};
max_delta_u = 0.3;
    % Macierz M
    for i = 1:N
        for j = 1:Nu
            if (i-j+1) > 0
                M(i,j) = s(i-j+1);
            else
                M(i,j) = {zeros(ny, nu)};
            end
        end
    end

    % Macierz Mpu
    for i = 1:N
        for j = 1:D-1
            Mp(i,j) = cellfun(@minus,s(min(i+j,D)),s(j),'Un',0);
        end
    end

    b = cell2mat(Mp);
    
    a = mat2cell(b, ones(N, 1)*ny, ones(D-1, 1)*nu);
    lambda = {diag(lambdas)};
    LAMBDA ={};
    for i=1:Nu
        for j = 1:Nu
            if i == j
                LAMBDA(i, j) = lambda;
            else
                LAMBDA(i, j) = {zeros(nu, nu)};
            end
        end
    end

    gamma = {diag(gammas)};
    GAMMA ={};
    for i=1:N
        for j = 1:N
            if i == j
                GAMMA(i, j) = gamma;
            else
                GAMMA(i, j) = {zeros(ny, ny)};
            end
        end
    end
    MT = cell2mat(M)';
    K = mat2cell(inv(MT * cell2mat(GAMMA) * cell2mat(M) + cell2mat(LAMBDA)) * MT * cell2mat(GAMMA), ones(Nu,1)*nu, ones(N,1)*ny);
   Y = [0;0;0];
   U = [0;0;0;0];
   for k = 2:sim_end
%         dUp = [];
        [Y(1, k), Y(2, k),Y(3, k)] = symulacja_obiektu4y_p4( ...
                U(1, (max(1, k-1))), U(1, (max(1, k-2))), U(1, (max(1, k-3))), U(1, (max(1, k-4))), ...
                U(2, (max(1, k-1))), U(2, (max(1, k-2))), U(2, (max(1, k-3))), U(2, (max(1, k-4))), ...
                U(3, (max(1, k-1))), U(3, (max(1, k-2))), U(3, (max(1, k-3))), U(3, (max(1, k-4))), ...
                U(4, (max(1, k-1))), U(4, (max(1, k-2))), U(4, (max(1, k-3))), U(4, (max(1, k-4))), ...
                Y(1, (max(1,k-1))), Y(1, (max(1, k-2))), Y(1, (max(1, k-3))), Y(1, max(1,k-4)), ...
                Y(2, (max(1,k-1))), Y(2, (max(1, k-2))), Y(2, (max(1, k-3))), Y(2, max(1,k-4)), ...
                Y(3, (max(1,k-1))), Y(3, (max(1, k-2))), Y(3, (max(1, k-3))), Y(3, max(1,k-4)));
        e(:, k) = yzad(:,k) - Y(:,k);
        Yzadk = repelem(yzad(:, k), N, 1);
        Yk = cell(N, 1);
        Yzadk = cell(N, 1);
        for i = 1:N
            Yzadk{i} = yzad(:, k);
            Yk{i} = Y(:, k);
        end
        dUp = cell(D-1, 1);
        for i = 1:D-1
            dUp{i} = U(:, max(k-i, 1)) - U(:, max(k-i-1, 1));
        end
        dY = cellfun(@minus,Yzadk,Yk,'Un',0);
        Mp_prod = cell2mat(Mp) * cell2mat(dUp);
        dU = cell2mat(K) * (cell2mat(dY) - Mp_prod);
        for i = 1:nu
            if abs(dU(i)) > max_delta_u
                dU(i) = max_delta_u * sign(dU(i));
            end
        end
        U(:,k) = U(:, k-1) + dU(1:nu);
%         deltaumax = [0.3, 0.3, 0.3]
%         deltau = U(k) - U(k-1);
%         U(k) = U(k-1) + min(abs(deltau), abs(deltaumax)) .* sign(deltau);
% 
%         % Sprawdzenie czy U znajduje się w przedziale, ew. ścięcie
%         U(k) = max(min(U(k), Umax), Umin);
   end
figure

locations = {'southeast','northeast', 'northeast'};
sgtitle("Wielowymiarowy analityczny regulator DMC")
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

matlab2tikz ('zad_6_dmc.tex' , 'showInfo' , false, 'standalone', true)

sum(sum(e.^2))