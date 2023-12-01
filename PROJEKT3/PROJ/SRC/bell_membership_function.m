function weights = bell_membership_function(point, number_of_regulators, parameters)
    for i =1:number_of_regulators
        weights(i) = 1/(1+((abs(point - parameters(i, 1))/parameters(i, 2))^(2*parameters(i, 3))));
    end
end

% parameters(i, 1) środek przedziału
% parameters(i, 2) szerokość
% parameters(i, 3) nachylenie
% wzór z tego miejsca https://home.agh.edu.pl/~mrzyglod/iw/iw_pliki/iw-is-ns-LR1-2019-2020.pdf