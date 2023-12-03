load('params40.mat', 'measurements1');
notnormalized_s_40 = measurements1;
load('params50.mat', 'measurements1');
notnormalized_s_50 = measurements1;
load('params60.mat', 'measurements1');
notnormalized_s_60 = measurements1;
load('params70.mat', 'measurements1');
notnormalized_s_70 = measurements1;
load('params80.mat', 'measurements1');
notnormalized_s_80 = measurements1;
% sim_end is mutual
sim_end = 300;

y_40 = notnormalized_s_40(1:sim_end);
y_50 = notnormalized_s_50(1:sim_end);
y_60 = notnormalized_s_60(1:sim_end);
y_70 = notnormalized_s_70(1:sim_end);
y_80 = notnormalized_s_80(1:sim_end);

% Upp_vect = [29, 29, 29];
u_vect = [40, 50, 60];
y_vect = [y_40, y_50, y_60];
Upp = 29;
Ypp = 34.9;
[s] = get_s_fuzzy_lab(Upp, Ypp, u_vect, y_vect);


plot(s')
