Umin= -1;
Umax = 1;
deltaumax = 0.03;

sim_end = 1000;

yzad(1:50) = 0;
yzad(51:300) = -0.15;
yzad(301:450) = 5;
yzad(451:650) = 0.2;
yzad(651:800) = -0.1;
yzad(801:sim_end) = 0.9;