Umin= -1;
Umax = 1;
deltaumax = 0.03;
load s_responses.mat
sim_end = 1000;

yzad(1:50) = 0;
yzad(51:300) = -0.15;
yzad(301:450) = 5;
yzad(451:650) = 0.2;
yzad(651:800) = -0.1;
yzad(801:sim_end) = 0.9;
D_vals = [120,120,120];
N = 120;
Nu = 50;
lambdas = [1,1,1];
z = [];
[u,y,e] = dmcfuzzy(s_vect, yzad, D_vals, z, N, Nu, lambdas);
figure
hold on
plot(y)
plot(yzad)
hold off
figure
plot(u)