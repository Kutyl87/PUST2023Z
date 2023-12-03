load step_response_parameters.mat
s_vect = get_s_fuzzy(Upp_vect,Ypp_vect, u_vect, sim_end);
save("s_responses.mat","s_vect" )
% D_v = [];
% for j =1:size(s_vect,1)
%     D = size(s_vect,2);
%     for i=2:size(s_vect,2)
%         if (s_vect(j,i)-s_vect(j,i-1) < EPS && abs(s_vect(j,i)) > 0.)
%             D = i;
%         break
%         end
%     end
%     D_v = [D_v;D];
% end
% D_v
probe_number_step = size(s_vect);
for i=1:probe_number_step(1)
    figure
    plot(s_vect(i,:),'DisplayName', string(i)+ " model lokalny",LineWidth=1,Color='red')
    legend('location', 'southeast');
    xlim([0,100])
    title("Odpowiedź skokowa")
    xlabel("Numer próbki - k")
    ylabel("Wartość na wyjściu układu")
    filename = "Odp_skok_" +string(i) +".tex";
    matlab2tikz(char(filename), 'showInfo' , false);
end