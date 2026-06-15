clc;
clear;
close all;
% c1 = [1,-1, 1, -1];
% c2 = [-1,1,1,1];


c1 = [ 1,-1,-1, 1,-1, 1,-1,-1,-1, 1, 1, 1, 1,-1,-1,-1, 1,-1,-1,-1, 1, 1, 1, 1, 1, 1, 1,-1,-1,-1, 1]';

c2 = [-1, 1, 1,-1, 1, 1, 1, 1, 1, 1, 1, 1,-1,-1, 1,-1,...
       -1, 1,-1, 1, 1, 1, 1, 1,-1,-1, 1,-1, 1,-1, 1]';

N = length(c1);

msg1 = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys';
msg2 = ' other syntax error To construct matrices use  brackets instead of parentheses ';

ascii1 = double(msg1);
ascii2 = double(msg2);

bits1 = de2bi(ascii1, 8, 'left-msb');
bits2 = de2bi(ascii2, 8, 'left-msb');

bits1_serial = bits1(:);
bits2_serial = bits2(:);

L1 = length(bits1_serial);
L2 = length(bits2_serial);

Lmax = max(L1, L2);  

bits1_serial1 = [bits1_serial; zeros(Lmax - L1, 1)];
bits2_serial2 = [bits2_serial; zeros(Lmax - L2, 1)];

b1 = 2*bits1_serial1 - 1;
b2 = 2*bits2_serial2 - 1;


s1 = kron(b1, c1);    % user 1 signal
s2 = kron(b2, c2);    % user 2 signal


tx = s1 + s2;
len = length(tx);
 noise = randn(1,len);
rx = tx+noise;


rx_blocks = reshape(rx, N, []).';

r1 = (rx_blocks * c1) / N;
r2 = (rx_blocks * c2) / N;

b1_hat = r1 > 0;
b2_hat = r2 > 0;

b1_hat = b1_hat(1:L1);
b2_hat = b2_hat(1:L2);

rec1 = reshape(b1_hat, [], 8);
rec2 = reshape(b2_hat, [], 8);

ascii1_rec = bi2de(rec1, 'left-msb');
ascii2_rec = bi2de(rec2, 'left-msb');

msg1_rec = char(ascii1_rec.');
msg2_rec = char(ascii2_rec.');

error1 = sum(bits1_serial ~= b1_hat);
error2 = sum(bits2_serial ~= b2_hat);

disp('Original Message 1:');
disp(msg1);
disp('Recovered Message 1:');
disp(msg1_rec);

disp('Original Message 2:');
disp(msg2);
disp('Recovered Message 2:');
disp(msg2_rec);

fprintf('Bit Errors User 1 = %d\n', error1);
fprintf('Bit Errors User 2 = %d\n', error2);
