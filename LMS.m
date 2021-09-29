clc;
close all;
clear variables;
N=1000;
t=0:N-1;
w0=0.01;  phi=0.1;
d=sin(2*pi*(1:N)*w0+phi); %transmitted signal
x=d+randn(1,N)*0.5; % signal with noise
h=zeros(1,N); 
mu=0.2;%mu is adaptive coefficient and is valued between 0 to 1(0.2 is the optimum value determined from 
       %trial and error) also step size.
       
k=10*N;
while k>0
e = d - h.*x;%estimation..
temp = h;
h=temp + mu*e .* x;%transfer function w.r.t input signal
k=k-1;
end
yd = h .* x;  

figure('name','transferFunction');
freqz(abs(h))

figure ('name','SignalPlot');
subplot(221),plot(t,d);
title('Input Signal'),ylim([-1.5 1.5]);grid;
subplot(222),plot(t,x);
title('Input Signal with Noise'),grid;
subplot(223),plot(t,e);grid
title('Error'),
subplot(224),plot(t,yd);grid;
title('Adaptive Equalized output');ylim([-1.5 1.5]);
