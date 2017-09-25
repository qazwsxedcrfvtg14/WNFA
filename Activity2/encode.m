%tx_vec : signal samples
input = '?' ;
bin=de2bi(uint8(char(input)));
%disp(bin);
input = zeros(1,8-size(bin,2));
for i = 1:size(bin,2)
    input=[input,bin(size(bin,2)-i+1)];
end
%bin=padarray(bin,8)
disp(input);
x = -pi:0.01:pi;
tx_vec = sin(x);
tx_vec = [];
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,ones(1,6666)];
for i = 1:8
    if input(i)
        tx_vec = [tx_vec,-ones(1,6666)];
        tx_vec = [tx_vec,ones(1,6666)];
    else
        tx_vec = [tx_vec,ones(1,6666)];
        tx_vec = [tx_vec,-ones(1,6666)];
    end
end
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,-ones(1,6666)];
tx_vec = [tx_vec,-ones(1,6666)];
%%save signal sample in the file
fid = fopen('txdata.bin','w');
%disp(real(tx_vec));
fwrite(fid, [real(tx_vec); imag(tx_vec)], 'float');
fclose(fid);