function weights = trapezoidal_membership_function(point, number_of_regulators, parameters)
    for i =1:number_of_regulators
        if parameters(i, 1) >= point || parameters(i, 4) <= point
            weights(i) = 0;
            continue
        end
        if parameters(i, 2) <= point && parameters(i, 3) >= point
            weights(i) = 1;
            continue
        end
        if parameters(i, 1) < point && parameters(i, 2) > point
            p = polyfit([parameters(i, 1), parameters(i, 2)], [0, 1], 1);
            weights(i) = polyval(p,point);
            continue
        end
        if parameters(i, 3) < point && parameters(i, 4) > point
            p = polyfit([parameters(i, 3), parameters(i, 4)], [1, 0], 1);
            weights(i) = polyval(p,point);
            continue
        end
    end
end