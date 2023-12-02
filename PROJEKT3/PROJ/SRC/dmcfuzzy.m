function [u, y, e] = dmcfuzzy(s_u_vals, yzad, D_vals, z, N, Nu, lambdas, Umin, Umax, deltaumax)
    kk = length(yzad);
    e = zeros(1, kk);
    M_pvals = {};
    K_vals = {};
    for m = 1:length(D_vals)
        D = D_vals(m);
        M = zeros(N,Nu);
        Mp = zeros(N,D-1);
        lambda = lambdas(m);
        for i = 1:N
            for j = 1:Nu
                if (i-j+1) > 0
                    M(i,j) = s_u_vals(m,i-j+1);
                end
            end
        end
        for i = 1:N
            for j = 1:D-1
                Mp(i,j) = s_u_vals(m,min(i+j,D)) - s_u_vals(m,j);
            end
        end
        Gamma = eye(N, N);
        Alpha = eye(Nu, Nu) * lambda;
        K = inv(M' * Gamma * M + Alpha) * M' * Gamma;
        M_pvals{end+1} = Mp;
        K_vals{end+1} = K;
    end
    u = zeros(1, kk);
    y = zeros(1, kk);

    for k = 2:kk
        y(k) =  symulacja_obiektu4y_p3(u(max(1, k-5)), u(max(1, k-6)), y(max(1, k-1)), y(max(1, k-2)));
        e(k) = yzad(k) - y(k);
        Yzadk = yzad(k) * ones(N, 1);
        Yk = y(k) * ones(N, 1);
        U_vals = [];
        for m = 1:length(D_vals)
            dUp = [];
            for i = 1:D_vals(m)-1
                dUp = [dUp; u(max(k-i, 1)) - u(max(k-i-1, 1))];
            end
            K = cell2mat(K_vals(m));
            M_p = cell2mat(M_pvals(m));
            dU = K* (Yzadk - Yk - M_p * dUp);
            u_reg = dU(1) + u(k-1);
            U_vals = [U_vals;u_reg];
        end

        %rozmycie
        mu_val = trapezoidal_membership_function(u(k-1), 3, [[-2, -1, -0.2, 0]; [-0.2, 0, 0.2, 0.4]; [0.2, 0.4, 1, 2]]);
        u_fuzzy = 0;
        for i = 1:length(D_vals)
            u_fuzzy = u_fuzzy + U_vals(i)*mu_val(i);
        end
        u(k) = u_fuzzy;
            %% Skalowanie wartości u
    % Sprawdzenie czy skok znajduje się w przedziale
        deltau = u(k) - u(k-1);
        u(k) = u(k-1) + min(abs(deltau), abs(deltaumax)) * sign(deltau);
    
    % Sprawdzenie czy U znajduje się w przedziale, ew. ścięcie
        u(k) = max(min(u(k),Umax),Umin);
    end
   
end