clear;clc;close all;

%% Exercise A

r = imnoise2('gaussian',100000,1,0,1);
figure, subplot(321)
hist(r,50)
title('(a)'),xlim([-5,5]),ylim([0,8000])

r = imnoise2('uniform',100000,1);
subplot(322)
hist(r,50)
title('(b)'),xlim([0,1]),ylim([0,4000])

r = imnoise2('lognormal',100000,1);
subplot(323)
hist(r,50)
title('(c)'),xlim([0,7]),ylim([0,10000])

r = imnoise2('rayleigh',100000,1);
subplot(324)
hist(r,50)
title('(d)'),xlim([0,4]),ylim([0,8000])

r = imnoise2('exponential',100000,1);
subplot(325)
hist(r,50)
title('(e)'),xlim([0,12]),ylim([0,24000])

r = imnoise2('erlang',100000,1);
subplot(326)
hist(r,50)
title('(f)'),xlim([0,10]),ylim([0,10000])

%% Exercise B

C = [0 64; 0 128; 32 32; 64 0; 128 0; -32 32];
[r, R, S] = imnoise3(512, 512, C);
S = bwmorph(S,'thicken');

figure, subplot(321), title('(a)')
imshow(S,[])

subplot(322), title('(b)')
imshow(r,[])

C = [0 32; 0 64; 16 16; 32 0; 64 0; -16 16];
[r, R, S] = imnoise3(512, 512, C);
S = bwmorph(S,'thicken');

subplot(323), title('(c)')
imshow(S,[])

subplot(324), title('(d)')
imshow(r,[])

C = [6 32; -2 2];
[r, R, S] = imnoise3(512, 512, C);

subplot(325), title('(e)')
imshow(r,[])

A = [1 5]; [r, R, S] = imnoise3(512, 512, C, A);

subplot(326), title('(f)')
imshow(r,[])
