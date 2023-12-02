function y_step_vect = step_simulation_fuzzy(u_pp_vect, y_pp_vect, u_vect, sim_end)
    y_step_vect = [];
    for j=1:length(u_pp_vect)
        Upp = u_pp_vect(j);
        u = u_vect(i);
        Ypp = y_pp_vect(i);
        y_step = ones(1, sim_end+1)*Ypp;
        u = ones(1, sim_end+1)*u;
        u(1) = Upp;      
        for i=2:sim_end+1
            y_step(i) = symulacja_obiektu4y_p3(u(max(1, i-5)), u(max(1, i-6)), y_step(max(1, i-1)), y_step(max(1, i-2)));
        end
        y_step_vect = [y_step_vect;y_step];
    end
end
    