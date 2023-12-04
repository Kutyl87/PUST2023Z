function y_step = step_simulation(Upp, Ypp, u, sim_end)
    y_step = ones(1, sim_end+1)*Ypp;
    u = ones(1, sim_end+1)*u;
    u(1) = Upp;
    
    for i=2:sim_end+1
        y_step(i) = symulacja_obiektu4y_p3(u(max(1, i-5)), u(max(1, i-6)), y_step(max(1, i-1)), y_step(max(1, i-2)));
    end
end