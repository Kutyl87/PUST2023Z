probe_number = size(Y_tested);
hold on
for i=1:probe_number(1)
    dispName = "D = " +string(D_tested(i))+ ", N = "+string(N_tested(i))+", N_{u} = " + string(Nu_tested(i)) + ', \lambda = ' + string(Lambdas(i));
    plot(Y_tested(i,:), 'DisplayName', dispName,LineWidth=0.7)
end
hold on
plot(Yzad,'DisplayName',"Wartość zadana",LineStyle="--")
title("Regulator DMC")
xlabel("Numer próbki")
ylabel("Wartość na wyjściu układu")
legend('location', 'southeast');
filename_dmc = "DMC_5_3_2" +".tex";
matlab2tikz(char(filename_dmc), 'showInfo' , false);
