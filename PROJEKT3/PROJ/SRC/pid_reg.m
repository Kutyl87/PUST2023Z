function [y, u, e] = pid_reg(Kp, Ti, Td, yzad, Upp, Ypp) 
    Umin= -1;
    Umax = 1;
    Tp=0.5;
    deltaumax = 0.03;
    kk = 400;
    u(1:kk)=Upp;
    y(1:kk)=Ypp;
    e(1:kk)=0;                   

    r1 = Kp*((Tp/(2*Ti)) -2 *(Td/Tp) -1);
    r2 = Kp*Td/Tp;
    r0 = Kp*(1+(Tp/(2*Ti)) + (Td/Tp));

    for k=12:kk
         y(k)=symulacja_obiektu4y_p3(u(k-5),u(k-6),y(k-1),y(k-2));
        e(k)=yzad(k)-y(k);
        u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
        
        %% Skalowanie wartości u
        
        % Sprawdzenie czy skok znajduje się w przedziale
        deltau = u(k) - u(k-1);
        u(k) = u(k-1) + min(abs(deltau), abs(deltaumax)) * sign(deltau);
        
        % Sprawdzenie czy U znajduje się w przedziale, ew. ścięcie
        u(k) = max(min(u(k),Umax),Umin);
    end
end