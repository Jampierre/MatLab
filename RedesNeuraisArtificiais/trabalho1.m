clear;
clc;

X = [0 1 0 1; 0 0 1 1];

%Perceptrion AND
W = [0.4 0.4];
b = -0.6;
yAND = yperceptron(X,W,b);
disp(yAND);


%Perceptrion OR
W = [0.6 0.6];
b = -0.1;
yOR = yperceptron(X,W,b);
disp(yOR);