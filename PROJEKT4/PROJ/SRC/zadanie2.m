sim_end = 200;
S = get_s([0,1,0,0], [0,0,0], sim_end);

nu = 4;
ny = 3;

figure;
number_plot = 1;
for y = 1:ny
    for u = 1:nu
       curr_s = zeros(1, sim_end+1);
       for i = 1:sim_end+1
           curr_s(i) = S{i}(y,u);
       end
       subplot(ny, nu, number_plot);
       plot([0:0.5:sim_end/2], curr_s);
       title(sprintf('ny=%d, nu=%d', y,u));
       xlabel('Czas[s]');
       ylabel('Wyjcie');
       number_plot = number_plot + 1;
    end
end