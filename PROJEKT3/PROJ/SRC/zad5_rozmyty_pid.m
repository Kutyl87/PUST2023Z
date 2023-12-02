number_of_regulators = 3;
Kp = [1.5, 0.23, 0.06];
Ti = [0.9, 2.4, 3];
Td = [1, 0.7, 0.1];

Umin= -1;
Umax = 1;
Tp=0.5;
deltaumax = 0.03;

sim_end = 500;

yzad(1:50) = 0;
yzad(51:300) = -0.15;
yzad(301:sim_end) = 4;

ur = zeros(number_of_regulators, 1);
y = zeros(sim_end, 1);
u = zeros(sim_end, 1);
weights = zeros(number_of_regulators, 1);

r1 = Kp.*((Tp./(2.*Ti)) -2 .*(Td./Tp) -1);
r2 = Kp.*Td./Tp;
r0 = Kp.*(1+(Tp./(2.*Ti)) + (Td./Tp));


for k=7:sim_end
    y(k) = symulacja_obiektu4y_p3(u(k-5),u(k-6),y(k-1),y(k-2));
    e(k)=yzad(k)-y(k);
    for reg=1:number_of_regulators
        ur(reg) = r2(reg)*e(k-2)+r1(reg)*e(k-1)+r0(reg)*e(k)+u(k-1);
    end
    weights = trapezoidal_membership_function(u(k-1), 3, [[-2, -1, -0.2, 0]; [-0.2, 0, 0.2, 0.4]; [0.2, 0.4, 1, 2]]);
    u(k) = weights * ur;

    %% Skalowanie wartości u
    % Sprawdzenie czy skok znajduje się w przedziale
    deltau = u(k) - u(k-1);
    u(k) = u(k-1) + min(abs(deltau), abs(deltaumax)) * sign(deltau);
    
    % Sprawdzenie czy U znajduje się w przedziale, ew. ścięcie
    u(k) = max(min(u(k),Umax),Umin);

end

figure
plot(y)
hold on
stairs(yzad)