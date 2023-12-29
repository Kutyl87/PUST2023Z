clear all;

s = get_s([0,0,0,0], [0,0,0], 200);
% % % fmincon 1
% % lambdas = [0.2131,    0.5200,   0.1594,    0.4096];
% % gammas = [9.7692,    5.8026,   25.5504];
% % 
% % % fmincon 2
% % lambdas = [0.9922    1.3952    2.3818    0.0004    ];
% % gammas = [3.4490    3.2444    2.3825];
% % 
% % %fmincon 3
% % lambdas = [0.3812    0.3972    0.5221    0.0017];
% % gammas = [1.3483    1.2535    0.8681];

% fmincon 4
% punkt startowy same 10
% blad 41.9938
lambdas = [1.9115    0.0025    6.2544    1.2379];
gammas = [6.1352    8.3933    8.9402];

%fmincon 5 większe delt_u_max
% blad 41.5638
% start zame zera
% lambdas = [0.3768    0.1468    1.4923    0.0014];
% gammas = [2.9257    2.6973    3.0956];

%fmincon 5 poprawiony
% blad 41.5638
% start zame zera
lambdas = [0.3768    0.1468    0.9923    0.25];
gammas = [2.9257    2.6973    3.0956];

% % only ones
% lambdas = [0.8, 0.3, 0.9, 0.5];
% gammas = [2.5, 3.5, 5];

nu = 4;
ny = 3;

max_delta_u = 0.3;

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
%     mat2cell(eye(Nu*nu))
    MT = cell2mat(M)';
    K = mat2cell(inv(MT * cell2mat(GAMMA) * cell2mat(M) + cell2mat(LAMBDA)) ...
        * MT * cell2mat(GAMMA), ones(Nu,1)*nu, ones(N,1)*ny);
   Ke = cell2mat(K(1, 1));
   for i=1:size(K, 2)
        Ke = Ke + cell2mat(K(1, i));
   end

   ku = {};
   for j = 1:size(Mp, 2)
       ku(j) = {cell2mat(K(1, :))*cell2mat(Mp(:, j))};
   end

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
%         for i = 1:D-1
%             dUp = [dUp, U(:, max(k-i, 1)) - U(:, max(k-i-1, 1))];
%         end
        duk = Ke*e(:, k);
        for i=1:D-1
            duk = duk - cell2mat(ku(i))*(U(:, max(k-i, 1)) - U(:, max(k-i-1, 1)));
        end
        for i = 1:nu
            if abs(duk(i)) > max_delta_u
                duk(i) = max_delta_u * sign(duk(i));
            end
        end

        U(:,k) = U(:, k-1)+duk;
        
%         deltaumax = [0.3, 0.3, 0.3]
%         deltau = U(k) - U(k-1);
%         U(k) = U(k-1) + min(abs(deltau), abs(deltaumax)) .* sign(deltau);
% 
%         % Sprawdzenie czy U znajduje się w przedziale, ew. ścięcie
%         U(k) = max(min(U(k), Umax), Umin);
   end
figure

locations = {'southeast','northeast', 'northeast'};
sgtitle({sprintf("Wielowymiarowy analityczny regulator DMC"), sprintf("Błąd = %.4f", sum(sum(e.^2)))})
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