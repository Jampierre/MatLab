clear all
clc
close all
 
a = -1;
b = 1; 
W = (b-a).*rand() + a;
b = (b-a).*rand() + a;
alfa = 0.001;
maxepocas = 10;
tol = 0.1;
X = randi(100,1,50);

intervalo=(min(X):10:max(X));
 
[Y] = yadaline(X,rand(),rand());
Y = -Y;
Y1 = Y + (rand(1, size(X, 2)) * 2 - 1); % ruido
[xp,cp] = mistura(X,Y1); 
%[xp,cp] = mistura(X,Y); 
 
figure(1);
grid on
hold on
 
plotadc2d(xp,cp,2);
legend('misturado');
%title('Amostra de Dados e Reta Original');
title('Amostra de Dados c/ ruido e Reta Original s/ ruido');
plot(X, Y, '-');
 
[W,b,Erroepocas] = treina_adaline(W,b,X,Y,alfa,maxepocas,tol);
 
figure(2);
plot(Erroepocas);
title('GRAFICO');
xlabel('Epocas');
ylabel('SEG');
title('SEQ x Epoca');
 
x = randi(100,1,50);
figure(3);
[y] = yadaline(x,W,b);
y1 = y +(rand(1, size(x, 2)) * 2 - 1); % ruido
hold on
plotadc2d(x,y1,2);
%plotadc2d(X,Y,2);
legend('treinado');
%legend('Amostra de treinamento com ruido');
plot(x, y, '-');
title('Resultado Novos(x,y)');
 
figure(4);
plot(X, Y, '-.',x,y,'-');
%legend('Reta original', 'Reta obitida pelo Adeline');
legend('Reta original s/ ruido', 'Reta obitida pelo Adeline');
title('Reta original e Treinada');