function s = get_s_u(Upp, Ypp, sim_end)
    % Returns vector of step response coefficients for steeling
    u_end = 1;
    y = step_simulation(u_end, 0, sim_end);
    y = y(1,3:length(y));
    s = zeros(1, length(y));
    for i=1:length(s)
        s(i) = (y(i) - Ypp) / (u_end - Upp);
    end
end
