function s = get_s_z(Zpp, Ypp, sim_end)
    % Returns vector of step response coefficients for interference
    z_end = 1;
    y = step_simulation(0, z_end, sim_end);
    y = y(1,3:length(y));
    s = zeros(1, length(y));
    for i=1:length(s)
        s(i) = (y(i) - Ypp) / (z_end - Zpp);
    end
end
