clear all;

s = get_s([0,0,0,0], [0,0,0], 200);
lambdas = [1, 1, 1, 1];
gammas = [10, 1, 4];

nu = 4;
ny = 3;

sim_end = 600;
yzad = zeros(ny, sim_end);
yzad(1,51:end) = ones(1, sim_end-50);
yzad(2,201:end) = ones(1, sim_end-200);
yzad(3,401:end) = ones(1, sim_end-400);

s(1)
s(2)
cellfun(@minus,s(2),s(1),'Un',0)

N = 200;
Nu = 200;
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
    K = mat2cell(inv(MT * cell2mat(GAMMA) * cell2mat(M) + cell2mat(LAMBDA)) * MT * cell2mat(GAMMA), ones(Nu,1)*nu, ones(N,1)*ny);
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
        dUp = [];
        [Y(1, k), Y(2, k),Y(3, k)] = symulacja_obiektu4y_p4( ...
                U(1, (max(1, k-1))), U(1, (max(1, k-2))), U(1, (max(1, k-3))), U(1, (max(1, k-4))), ...
                U(2, (max(1, k-1))), U(2, (max(1, k-2))), U(2, (max(1, k-3))), U(2, (max(1, k-4))), ...
                U(3, (max(1, k-1))), U(3, (max(1, k-2))), U(3, (max(1, k-3))), U(3, (max(1, k-4))), ...
                U(4, (max(1, k-1))), U(4, (max(1, k-2))), U(4, (max(1, k-3))), U(4, (max(1, k-4))), ...
                Y(1, (max(1,k-1))), Y(1, (max(1, k-2))), Y(1, (max(1, k-3))), Y(1, max(1,k-4)), ...
                Y(2, (max(1,k-1))), Y(2, (max(1, k-2))), Y(2, (max(1, k-3))), Y(2, max(1,k-4)), ...
                Y(3, (max(1,k-1))), Y(3, (max(1, k-2))), Y(3, (max(1, k-3))), Y(3, max(1,k-4)));
        e(:, k) = yzad(:,k) - Y(:,k);
        for i = 1:D-1
            dUp = [dUp, U(:, max(k-i, 1)) - U(:, max(k-i-1, 1))];
        end
        duk = Ke*e(:, k);
        for i=1:D-1
            duk = duk - cell2mat(ku(i))*dUp(:, i);
        end
        U(:,k) = U(:, k-1)+duk;
   end
figure

sgtitle("Wielowymiarowy analityczny regulator DMC")
for i=1:ny
    subplot(2, 2, i)
    title("Wyjście "+string(i))
    hold on
    plot(Y(i, :))
    stairs(yzad(i, :))
end
subplot(2, 2, 4)
title("Sterowanie")
for i=1:nu
    hold on
    stairs(U(i, :))
end
% plot(yzad(1, :))