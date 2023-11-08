function s = get_s_u_cut(Upp, Ypp, sim_end, max_diff)
    % Returns vector of step response coefficients for steeling
    s = get_s_u(Upp, Ypp, sim_end);
    stop_time = 0;
    
    for i=2:sim_end
        if (s(i) ~= 0 && abs(s(i) - s(i-1)) < max_diff)
            stop_time = i;
            break
        end    
    end
    s = s(1:stop_time);
end
