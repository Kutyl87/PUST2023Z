// Do inita
(* Program content *)
Ke_11 := 111; // liczba z matlaba
Ke_12 := 111;
Ke_21 := 111;
Ke_22 := 111;

// typ array rozmiar D-1
ku1 := []; // liczba z matlaba
ku2 := [];
ku3 := [];
ku4 := [];

u1[0] := 29 // dłukości D + 2 dla bezpieczeństwa
u2[0] := 34

k := 1

nu := 2;
ny := 2;
D := 700;

// W głównym regulatorze

PROGRAM PLC_PGR

y1 := D100;
y2 := D102;

e1 := yzad1 - y1;
e2 := yzad2 - y2;

duk1 := Ke_11 * e1 + Ke_12 * e2
duk2 := Ke_21 * e1 + Ke_22 * e2

FOR i := 0 TO D - 1 DO
  duk1 := duk1 - ku1[i] * (u1[i] - u1[i + 1]) - ku2[i] * (u2[i] - u2[i + 1]);
  duk2 := duk2 - ku3[i] * (u1[i] - u1[i + 1]) - ku4[i] * (u2[i] - u2[i + 1]);
END_FOR;

u_k_1 := u1[0] + duk1;
u_k_2 := u2[0] + duk2;
// Tutaj ify z ograniczeniami na u_k

// PRzesuwanie macierzy sterowania


FOR i := D TO 1 BY - 1 DO
    u1[i] := u1[i - 1];
    u2[i] := u2[i - 1];
END_FOR;

u1[0] := u_k_1;
u2[0] := u_k_2;

END_PROGRAM