
M=16; % M-ary modulation - M different symbols
n=16; % n data symbols to be trasnmitted
%data=randi(M,1,n); %%generate n random data symbols
data=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
%data=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];
%data=[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 ];
%data=[3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 ];
%f_c=10e1; % 100 KHz carrier frequency
f_c=10e3; % 100 KHz carrier frequency
T_s=1e-3; % 1 ms (10^-3 second) symbol duration
T_sample=1e-6; %Sampling duration = 1us (10^-6 second)
%M=4; %M-ary modulation
%phi_table=[pi/4 3*pi/4 5*pi/4 7*pi/4];
%phi=phi_table(data)
%%I and Q symbol table (QPSK) ******* MODIFY here!

I_table=[-3/2 -1/2 1/2 3/2];
Q_table=[-3/2 -1/2 1/2 3/2];
I=I_table(mod(int32(data)-1,4)+1);
Q=Q_table(idivide(int32(data)-1,4)+1);
phi=atan2(Q,I);
A=sqrt(power(Q,2)+power(I,2));

t=[0:T_sample:n*T_s-T_sample];

figure(1); %plot all symbols on signal constellation

for i=1:M
%plot(cos(phi_table(i)),sin(phi_table(i)),'bo');
plot(I(i),Q(i),'bo');
hold on;
text(I(i),Q(i),['s' int2str(i-1) '\rightarrow  '],'HorizontalAlignment','right')
end
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');

figure(2);
subplot(8,1,1);
plot(T_s/2+T_s*[0:n-1],data,'bo'); %plot data
axis([0 T_s*n 0 M+1]);

%resample phi at sampling frequency
phi_m=repelem(phi, round(T_s/T_sample));

subplot(8,1,2);
plot(t,phi_m);
ylabel('phase \phi_m');

subplot(8,1,3);
I_m=repelem(I, round(T_s/T_sample));
plot(t,I_m);
ylabel('phase I_m');

subplot(8,1,4);
Q_m=repelem(Q, round(T_s/T_sample));
plot(t,Q_m);
ylabel('phase Q_m');

subplot(8,1,5);
%add your code here to plot the in-phase signal
resultI=cos(2*pi*f_c*t).*I_m;
plot(t,resultI);
ylabel('in-phase');%in-phase signal

subplot(8,1,6);
%add your code here to plot the quadrature signal
resultQ=cos(2*pi*f_c*t+pi/2).*Q_m;
plot(t,resultQ);
ylabel('quadrature');%quadrature signal

%disp(A)
%disp(I)
%disp(Q)
subplot(8,1,7);
A_m=repelem(A, round(T_s/T_sample));
result=cos(2*pi*f_c*t+phi_m).*A_m;
plot(t,result);
ylabel('waveform');%modulated waveform

subplot(8,1,8);
plot(t,resultI+resultQ);
ylabel('waveform');%modulated waveform



