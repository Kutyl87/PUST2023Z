%% 
Ypp = 0;
Upp = 0;
Zpp = 0;
sim_end = 200;
offset = 0.5;

%% Skok jednostkowy dla sygnału sterującego - nieodcięty
% s_u = get_s_u(Upp, Ypp, sim_end);
% plot(s_u)
% grid on
% grid minor
% title('Znormalizowana nieodcięta odpowiedź skokowa dla sygnału sterującego')
% xlabel('Próbka, k')
% ylabel('Wartości s')
% ylim([0, max(s_u)+ offset])
% matlab2tikz ('zad3_s_u_nieodc.tex' , 'showInfo' , false) 

%% Skok jednostkowy dla sygnału sterującego - odcięty
% max_diff_u = 0.00007;
% s_u_cut = get_s_u_cut(Upp, Ypp, sim_end, max_diff_u);
% plot(s_u_cut);
% grid on
% grid minor
% title('Znormalizowana odcięta odpowiedź skokowa dla sygnału sterującego')
% xlabel('Próbka, k')
% ylabel('Wartości s')
% ylim([0, max(s_u_cut)+ offset])
% matlab2tikz ('zad3_s_u_odc.tex' , 'showInfo' , false) 

%% Skok jednostkowy dla zakłóceń - nieodcięty
% s_z = get_s_z(Zpp, Ypp, sim_end);
% plot(s_z)
% ylim([0, max(s_z)+offset])
% grid on
% grid minor
% title('Znormalizowana nieodcięta odpowiedź skokowa dla zakłóceń')
% xlabel('Próbka, k')
% ylabel('Wartości s')
% matlab2tikz ('zad3_s_z_nieodc.tex' , 'showInfo' , false) 

%% Skok jednostkowy dla zakłóceń - odcięty
max_diff_z = 0.000075;
s_z_cut = get_s_z_cut(Zpp, Ypp, sim_end, max_diff_z);
figure;
plot(s_z_cut)
ylim([0, max(s_z_cut)+offset])
grid on
grid minor
title('Znormalizowana odpowiedź skokowa dla zakłóceń')
xlabel('Próbka, k')
ylabel('Wartości s')
matlab2tikz ('zad3_s_z_odc.tex' , 'showInfo' , false) 
