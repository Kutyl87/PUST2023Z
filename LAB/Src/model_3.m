a = fmincon(@calculate_transfer_parameters,[0.35, 10, 20], [], [], [], [], [0, 0, 0], [1000, 1000, 1000]);
function error = calculate_transfer_parameters(x)
    K = x(1);
    T1 = x(2);
    T2 = x(3);
    load params.mat;
    Td = 15;
    y = measurements1;
    y_size = size(y);
    kk = y_size(1);
    u(1:kk) = 8;
    u(1) = 0;
    y_w = model(u,y,kk,Td, K, T1, T2);
    size(y)
    size(y_w)
    error = calculate_square_error(y,y_w');
    % error
end
function error = calculate_square_error(y_zad, y_wy)
s = (y_zad-y_wy);
error = sum((y_zad-y_wy).^2);
end