clear all
clc
close all

%nc = randi(10,1,1);
nc = 3;
npc = randi(100,1,nc);
mc = 10.*rand(2,nc);
varc = rand(2,nc); 

[xp,cp] = geragauss(nc,npc,mc,varc);

[xp,cp] = mistura(xp,cp);

figure(1);
grid on
hold on
plotadc2d(xp,cp);
xlabel('X1');
ylabel('X2');
title('Dados aleatórios de duas dimensões');

a = -ones(nc,size(xp, 1));
b = ones(nc,size(xp, 1));

W = (b-a).*rand(3, size(xp, 1))+ a;
b = ones(1, size(W, 1));
alfa = 0.8;
maxepocas = 50;
tol = 0.001;

Yd = converte_dec_bin(cp);
for i=1:size(W, 1)
    [W(i,:),b(i),Erroepocas(i,:)] = treina_perceptron(W(i,:),b(i),xp,Yd(i,:),alfa,maxepocas,tol);
end

intervalo=(-10:1:10);
figure(2);
hold on
for i=1:size(Erroepocas,1)
    plot(Erroepocas(i,:));
end
title('GRAFICO');
xlabel('Epocas');
ylabel('SEG');
legend('perceptron 1','perceptron 2','perceptron 3');

figure(3);
hold on
for i=1:size(W,1)
    plotareta(W(i,:),b(i),intervalo);
end
plotadc2d(xp,cp);
xlabel('X1');
ylabel('X2');
title('Dados aleatórios de duas dimensões');

y = [];
for i=1:size(W,1) 
    [y(i,:)] = yperceptron(xp,W(i,:),b(i));
end

figure(4);
hold on
rc = converte_bin_dec(y);
for i=1:size(W, 1) 
    plotareta(W(i,:),b(i),intervalo);
end
plotadc2d(xp, rc);
title('Dados reclassificados');
xlabel('X1');
ylabel('X2');