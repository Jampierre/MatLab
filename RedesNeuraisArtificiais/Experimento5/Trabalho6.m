clear all
clc
close all
 
a = -1;
b = 1; 

W = (b-a).*rand() + a;
b = (b-a).*rand() + a;
alfa = 0.00001;
maxepocas = 10;
tol = 0.1;
taxa_momento = (0.9-0.5).*rand() + 0.5;
X = randi(100,1,50);
Y = yadaline(X,W,b) +(rand(1, size(X, 2)) * 2 - 1);

W_m = W;
b_m = b;
X_m = X;
Y_m = Y;

[W,b,Erroepocas] = treina_adaline(W,b,X,Y,alfa,maxepocas,tol);
[W_m,b_m,Erroepocas_m] = treina_adaline_m(W_m,b_m,X_m,Y_m,alfa,maxepocas,tol,taxa_momento);

figure(1);
plot(Erroepocas);
title('Erro quadratico x Epoca');

figure(2);
plot(Erroepocas_m);
title('Erro quadratico x Epoca');
