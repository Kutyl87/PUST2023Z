D = 65;
N= 10;
Nu  = 2;
Umin= -1;
Umax = 1;
deltaumax = 0.03;
% Pierwszy regulator DMC
% Yzad(1:200) = -0.21;
% Yzad(201:400) = -0.17;
% Drugi regulator DMc
% Yzad(1:200) = 0;
% Yzad(201:400) = 0.5;
% Trzeci regulator DMc
Yzad(1:200) = 3.5;
Yzad(201:400) = 4.5;
lambda = 1;
[u, y, e] = dmcfunction(s_vect(3,:),Yzad, D, N, Nu, lambda, deltaumax, Umin, Umax);
figure
hold on
plot(y)
plot(Yzad)
hold off
figure
plot(u)
%Y_tested = [];Lambdas = [];N_tested = [];Nu_tested = [];D_tested=[];e_tested =[]
Lambdas = [Lambdas; lambda];
Y_tested = [Y_tested;y];
D_tested = [D_tested;D];
N_tested = [N_tested;N];
Nu_tested = [Nu_tested;Nu];
e_tested = [e_tested;sum(e).^2]