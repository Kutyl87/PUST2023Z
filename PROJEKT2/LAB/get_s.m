function s = get_s(sim_end)
    Ypp = 32.68;
    Upp = 29;
%     y = readmatrix("pqfile.txt");
%     y = y(:, 4);

    y = readmatrix("pqfile.txt");
    y = y(:, 4);
    y_size = size(y);
    kk = y_size(1);
    u(1:kk) = 39;
    u(1) = 29;
    yx = modelm(u,y,kk);
    yx = yx(5:end);
    s = zeros(1, sim_end);
    for i=1:length(s)
        s(i) = (yx(i) - Ypp) / (39 - Upp);
    end
end

function y_w = modelm(u, y, kk)
T1 =1.0001;
T2 =108.0218;
K =  0.9340 ;
Td = 15;
alfa1 = exp(-1/T1);
alfa2 =exp(-1/T2);
y_w(1:kk) = y(1);
a1 = -alfa1-alfa2;
a2 = alfa1*alfa2;
b1 = (K / (T1 - T2)) * (T1*(1-alfa1) - T2*(1-alfa2));
b2 = (K/(T1 - T2)) * (alfa1 * T2 *(1-alfa2) - alfa2*T1*(1-alfa1));
for k=Td+3:kk
y_w(k) = b1*u(k - Td - 1) + b2*u(k- Td -2) - a1*y_w(k- 1) - a2*y_w(k - 2);
end
end