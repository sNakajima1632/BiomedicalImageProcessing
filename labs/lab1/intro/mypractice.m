clear;clc;

%% 2
a = [1 2; 3 4];
a = [a, a'; a',a]

%% 3
a(:,2)

%% 4
save myfile.mat;
load myfile.mat

%% 5
f = 71;
c = (f-32)/1.8;
tempText = "Temperature is " + c + "C"

%% 6
disp("hello world")

%% 7
t = 0:pi/10:2*pi;
[X,Y,Z] = cylinder(4*cos(t));
subplot(2,2,1); mesh(X); title('X');
subplot(2,2,2); mesh(Y); title('Y');
subplot(2,2,3); mesh(Z); title('Z');
subplot(2,2,4); mesh(X,Y,Z); title('X,Y,Z');

%% 8
num = randi(100);
if num < 34
    sz = 'low'
elseif num < 67
    sz = 'medium'
else
    sz = 'high'
end

%% 9
doc mean

%% 10
B = zeros(4,4);
for i = 1:16
    B(i) = i;
end
B'

%% 11
mean(B)

%% 12
B(1,4)

%% 13
B(1:2:15)

%% 14 and 15 are summaries

%% 16
A = [1,2;3,4];
[A;A(end:-1:1,:)]

%% 17
B(3,:) = []

%% 18
B*a

%% 19 is also a summary

%% 20
help elfun