function z = get_sin_z(max_value, period, sim_end_10x_smaller)
    frequency = 1 / period;
    t = 0:0.1:sim_end_10x_smaller;
    z = max_value * sin(2*pi* frequency* t);
    % z(i) = max_value*sin(i*period);
end
