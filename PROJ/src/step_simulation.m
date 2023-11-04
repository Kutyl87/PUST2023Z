function y_step = step_simulation(u, z, sim_end)
    Ypp = 0;
    Upp = 0;
    Zpp = 0;
    y_step = ones(1, sim_end+1)*Ypp;
    u = ones(1, sim_end+1)*u;
    u(1) = Upp;
    z = ones(1, sim_end+1)*z;
    z(1) = Zpp;
    
    for i=2:sim_end+1
        y_step(i) = symulacja_obiektu4y_p2(u(max(1, i-6)), u(max(1, i-7)), z(max(1, i-2)), z(max(1, i-3)), y_step(max(1, i-1)), y_step(max(1, i-2)));
    end
end