Upp_vect = [-1, 0.05,0.7];
u_vect = [-0.8, 0.12, 0.8];
Ypp_vect = [];

for i=1:length(Upp_vect)
    s = step_simulation(Upp_vect(i),1,Upp_vect(i), sim_end);
    Ypp_vect = [Ypp_vect,s(end)];
end
save("step_response_parameters.mat","Upp_vect","Ypp_vect","u_vect")