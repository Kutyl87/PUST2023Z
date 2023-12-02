load step_response_parameters.mat
s_vect = get_s_fuzzy(Upp_vect,Ypp_vect, u_vect, sim_end);
plot(s_vect')