function s = get_zs(sim_end)
    Ypp = 33.8;
    Upp = 0;
%     y = readmatrix("pqfile.txt");
%     y = y(:, 4);

    load params.mat;
    y = measurements1;
    y_size = size(y);
    kk = sim_end+1;
    u(1:kk) = 8;
    u(1) = 0;
    yx = modelm(u,y,kk);
    yx = yx(2:end);
%     plot(yx)
%     figure
    s = zeros(1, sim_end);
    for i=1:length(s)
        (yx(i) - Ypp)
        (8 - Upp)
        s(i) = (yx(i) - Ypp) / (8 - Upp);
        s(i)
    end
end

function y_w = modelm(u, y, kk)
    T1 =75.416340098855372;
    T2 =0.000000154186551;
    K =  4.382457806101944 ;
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