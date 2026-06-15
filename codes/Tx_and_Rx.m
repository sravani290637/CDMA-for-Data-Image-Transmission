%transmission and reception of message signals

clc;
close all;
clear all;

c1=[ 1    -1     1    -1    -1    -1    -1];
c2=[ -1     1    -1    -1    -1     1    -1];

L = 4;
m1 = [1 -1 1 -1];
m2 = [-1 -1 1 1];

s1 = kron(m1, c1);
s2 = kron(m2, c2);

tx = s1 + s2;
rx1 = zeros(1,L);
N = 7;
for k = 1:L
    segment = tx((k-1)*N + 1 : k*N);
    rx1(k) = sign(sum(segment .* c1) / N);
end
m1_hat = rx1;

rx2 = zeros(1,L);

for k = 1:L
    segment = tx((k-1)*N + 1 : k*N);
    rx2(k) = sign(sum(segment .* c2) / N);
end

m2_hat = rx2;

disp('Original m1:'), disp(m1)
disp('Recovered m1:'), disp(m1_hat)

disp('Original m2:'), disp(m2)
disp('Recovered m2:'), disp(m2_hat)
