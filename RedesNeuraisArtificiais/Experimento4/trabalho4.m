clear all
clc
close all

%nc = randi(10,1,1);
nc = 2;
npc = randi(100,1,nc);
mc = 10.*rand(2,nc);
varc = rand(2,nc); 

[xp,cp] = geragauss(nc,npc,mc,varc);

[xp,cp] = mistura(xp,cp);

figure(1);
grid on
hold on
plotadc2d(xp,cp);

a = -1;
b = 1;

W = [((b-a).*rand() + a) ((b-a).*rand() + a)];
b = (b-a).*rand() + a;
alfa = 1.2;
maxepocas = 10;
tol = 0.001;

[W,b,Erroepocas] = treina_perceptron(W,b,xp,cp,alfa,maxepocas,tol);

intervalo=(-10:0.001:10);

figure(2);
plot(Erroepocas);
title('GRAFICO');
xlabel('Epocas');
ylabel('SEG');

figure(3);
[y] = yperceptron(xp,W,b);

hold on
plotadc2d(xp,y);
plotareta(W,b,intervalo)