clear;clc;close all;

%% 7
sigx = 0.1;
sigy = [0.5 1 2 5];

[x,y] = meshgrid(-2:.2:2);

Z1 = exp(-(x.^2/(2*sigx^2) + y.^2./(x*sigy(1)^2)));
Z2 = exp(-(x.^2/(2*sigx^2) + y.^2./(x*sigy(2)^2)));
Z3 = exp(-(x.^2/(2*sigx^2) + y.^2./(x*sigy(3)^2)));
Z4 = exp(-(x.^2/(2*sigx^2) + y.^2./(x*sigy(4)^2)));

subplot(2,2,1);
    surf(x,y,Z1);
    title('sigma-y = 0.5');
subplot(2,2,2);
    surf(x,y,Z2);
    title('sigma-y = 1');
subplot(2,2,3);
    surf(x,y,Z3);
    title('sigma-y = 5');
subplot(2,2,4);
    surf(x,y,Z4);
    title('sigma-y = 5');

%% 8
edit mysphere