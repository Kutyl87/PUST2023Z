kk = 1000;
    yzad(1:260)=20;
    yzad(261:451)= 30.7;
    yzad(452:762) = 10.7;
    yzad(763:898) = 25.8;
    yzad(899:kk) = 35.9;

[u, y, e] = dmcfunction(yzad, 120, 50, [zeros(1, kk/2), ones(1, kk/2)], 60, 60, 1, 3, -30, 30);

figure
plot(y)
figure
plot(u)