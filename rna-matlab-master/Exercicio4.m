%
%
%
%
%
%
%

b = rand();
a = rand();
c = rand();

X = [0 : 0.3 : 10];
Yd = a*X + c;

figure(1);
plot(X, Yd, 'o');

W = rand(1, size(X,1)) * 2 - 1;

maxepocas = 10;
tol = 0.1;
alfa = 0.001;

[ W, b, erroEpoca] = treina_adaline(W,b,X,Yd,alfa,maxepocas,tol);

figure(2);
plot(erroEpoca);
title('SEQ x �poca');
xlabel('�poca');
ylabel('SEQ');

%Gerar novo vetor X
Xs = [0 : 0.5 : 10];
Ys = yadaline(W, b, Xs);

figure(3);
hold on
plot(Xs, Ys, '-');
title('Gera��o de dados e aprendizado Adaline');
xlabel('X');
ylabel('Y');
legend({'Dados', 'Fun��o aprendida'});
