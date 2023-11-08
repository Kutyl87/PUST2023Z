function s = get_s_u(Upp, Ypp, sim_end)
    % Returns vector of step response coefficients for steeling
    u_end = 1;
    y = step_simulation(u_end, 0, sim_end);
    s = zeros(1, sim_end);
    for i=1:length(s)
        s(i) = (y(i) - Ypp) / (u_end - Upp);
    end
end
