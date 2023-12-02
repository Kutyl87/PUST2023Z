function s_vect = get_s_fuzzy(Upp_vect, Ypp_vect,u_vect, sim_end)
    % Returns vector of step response coefficients for steeling
    s_vect = [];
    for j=1:length(Upp_vect)
        Upp = Upp_vect(j);
        u = u_vect(j);
        Ypp = Ypp_vect(j);
        y = step_simulation(Upp,Ypp,u, sim_end);
        y = y(3:end);
        s = zeros(1, length(y));
        (y(end) - Ypp) / (u - Upp)
        % for i=1:length(s)
        %     s(i) = (y(i) - Ypp) / (u - Upp);
        % end
        s_vect = [s_vect;s];
    end
end