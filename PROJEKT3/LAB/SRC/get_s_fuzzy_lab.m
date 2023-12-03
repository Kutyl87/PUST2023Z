
function s_vect = get_s_fuzzy_lab(Upp, Ypp, u_vect, y_vect)
    % Returns vector of step response coefficients for steeling
    s_vect = [];
    for j=1:3
        u = u_vect(j);
        % Ypp = Ypp_vect(j);
        % y = step_simulation(Upp,Ypp,u, sim_end);
        % y = y(3:end);
        y = y_vect(:,j);
        % y = y(1:sim_end);
        s = zeros(1, length(y));
        for i=1:length(s)
            s(i) = (y(i) - Ypp) / (u - Upp);
        end
        s_vect = [s_vect;s];
    end
end