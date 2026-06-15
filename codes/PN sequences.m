% Generation of PN Sequences

clc;
clear all;
close all;
n = 4;
k=[1 zeros(1,n-1)];
seq = primpoly(n,'all');
seq = de2bi(seq,n+1,'left-msb');
p=1;
op = [zeros(1,n)];
w = size(seq ,1);
len = pow2(n)-1;
PN = zeros(2,len);
for m = 1:1:w
    for i = 1:1:len;
        for j = 1:1:n
            if seq(m,(n+1-j)) == 1
               op(p) = k(j);
               p = p+1;
            end
        end
        temp = mod(sum(op),2);
        k = [0 k(1:end-1)];
        k(1) = temp;
        PN(m,i) = k(1);
        p = 1;
    end
end
display(PN);

% Refer to PNSequence.png

