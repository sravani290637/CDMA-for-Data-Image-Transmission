% image transmission using gold sequences

clc;
clear;
close all;


 c1=[ 1    -1     1    -1    -1    -1    -1];
 c2=[ -1     1    -1    -1    -1     1    -1];


c1 = c1(:); 
c2 = c2(:);

N = length(c1);   

img1 = imread("flower.jpeg");
img2 = imread("map.jpg");
img1 = imresize(img1,[128 128]);
img2 = imresize(img2,[128 128]);

bits1 = de2bi(img1,8,'left-msb');
bits2 = de2bi(img2,8,'left-msb');

bits1_serial = bits1(:);
bits2_serial = bits2(:);
bit1_check = bits1_serial.';
bit2_check = bits2_serial.';
b1 = double(2*bits1_serial - 1)
b2 = double(2*bits2_serial - 1);

s1 = kron(b1, c1);   % user 1
s2 = kron(b2, c2);   % user 2

tx = s1 + s2;        % superposition
rx = tx;             % ideal channel (no noise for now)


rx_blocks = reshape(rx, N, []).';  
r1 = rx_blocks * c1;
r1 = r1 / N;
b1_hat = r1 > 0

r2 = rx_blocks * c2;
r2 = r2 / N;
b2_hat = r2 > 0;

rec1 = reshape(b1_hat, [], 8);
rec2 = reshape(b2_hat, [], 8);

img1_rec = uint8(bi2de(rec1,'left-msb'));
img2_rec = uint8(bi2de(rec2,'left-msb'));

img1_rec = reshape(img1_rec, size(img1));
img2_rec = reshape(img2_rec, size(img2));

bits1_rec = de2bi(img1,8,'left-msb');
bits2_rec = de2bi(img2,8,'left-msb');

bit1_serial_rec = bits1_rec(:);
bit2_serial_rec = bits2_rec(:);

bit1_check_rec = bit1_serial_rec.';
bit2_check_rec = bit2_serial_rec.';


error1 = sum(bit1_check ~= bit1_check_rec )
error2 = sum(bit2_check ~= bit2_check_rec )

figure;
subplot(2,2,1), imshow(img1), title('Original Image 1');
subplot(2,2,2), imshow(img1_rec), title('Recovered Image 1');

subplot(2,2,3), imshow(img2), title('Original Image 2');
subplot(2,2,4), imshow(img2_rec), title('Recovered Image 2');
