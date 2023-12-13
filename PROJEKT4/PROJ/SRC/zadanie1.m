clear all;
sim_end = 299;
U1pp = 0;
U2pp = 0;
U3pp = 0;
U4pp = 0;
Y1pp = 0;
Y2pp = 0;
Y3pp = 0;

y_step1 = ones(1, sim_end + 1) * 12;
y_step2 = ones(1, sim_end + 1) * 12;
y_step3 = ones(1, sim_end + 1) * 12;
u1 = ones(1, sim_end+1)*U1pp;
u1(1) = 1;
u2 = ones(1, sim_end+1)*U2pp;
% u2(1) = 1;
u3 = ones(1, sim_end+1)*U3pp;
% u3(1) = 1;
u4 = ones(1, sim_end+1)*U4pp;
% u4(1) = 1;

for i=2:sim_end+1
    [y_step1(i), y_step2(i), y_step3(i)] = symulacja_obiektu4y_p4( ...
        u1(max(1,i-1)), u1(max(1,i-2)), u1(max(1,i-3)), u1(max(1,i-4)), ...
        u2(max(1,i-1)), u2(max(1,i-2)), u2(max(1,i-3)), u2(max(1,i-4)), ...
        u3(max(1,i-1)), u3(max(1,i-2)), u3(max(1,i-3)), u3(max(1,i-4)), ...
        u4(max(1,i-1)), u4(max(1,i-2)), u4(max(1,i-3)), u4(max(1,i-4)), ...
        y_step1(max(1,i-1)), y_step1(max(1,i-2)), y_step1(max(1,i-3)), y_step1(max(1,i-4)), ...
        y_step2(max(1,i-1)), y_step2(max(1,i-2)), y_step2(max(1,i-3)), y_step2(max(1,i-4)), ...
        y_step3(max(1,i-1)), y_step3(max(1,i-2)), y_step3(max(1,i-3)), y_step3(max(1,i-4)) ...
    );
end
x = linspace(0, sim_end, sim_end+1);
plot(x, y_step1, x, y_step2, x, y_step3);
title('Sprawdzenie wartości punktu pracy');
xlabel('k');
ylabel('Wyjście');
legend('y_{zad1}', 'y_{zad2}', 'y_{zad3}');
