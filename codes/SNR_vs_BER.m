% SNR vs BER plot for bpsk modulation over AWGN channel

clc;
clear all;
close all;

len = 10^6;
SNR = 0:0.5:12;

msg = randn(1,len);

for i = 1:length(SNR)

    snr = 10^(SNR(i)/10);         
    var = sqrt(1/(2*snr));      

    tx = 2*(msg > 0) - 1;          % BPSK modulation
    msg_tx = tx > 0;
    rx = tx + var*randn(1,len);  % noise

    msg_rec = rx > 0;              % detection

    bit_error(i) = sum(msg_tx ~= msg_rec)/len;

end

semilogy(SNR,bit_error);
xlabel('SNR (dB)')
ylabel('BER')

% For plot refer to SNR_vs_BER.png
