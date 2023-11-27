
function [white_noise] = white_gaussian_noise(sizex, mean_val, std_dev)
    white_noise = mean_val + std_dev * randn(1, sizex);
end