clear all;

s = get_s(200);
lambdas = [0.8, 0.3, 0.9, 1];
gammas = [2.5, 3.5, 5];

nu = 2;
ny = 2;

N = 150;
Nu = 100;
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

   kuj = cell2mat(ku);