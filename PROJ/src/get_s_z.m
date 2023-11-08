function s = get_s_z(Zpp, Ypp, sim_end)
    % Returns vector of step response coefficients for interference
    z_end = 1;
    y = step_simulation(0, z_end, sim_end);
    s = zeros(1, sim_end);
    for i=1:length(s)
        s(i) = (y(i) - Ypp) / (z_end - Zpp);
    end
end
