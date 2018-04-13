%
%
%
%
%
%

a = rand();
b = rand();
c = rand();

X = [0 : 0.3 :10];
Yd = a*X + c + (rand(1, size(X, 2)) * 2 - 1);
W = rand(1, size(X,1)) * 2 - 1;

maxepocas = 30;
tol = 0;
alfa = 0.0001;
beta = 0.7;

[ W_m, b_m, erroEpoca_m] = treina_adaline_m(W,b,X,Yd,alfa,maxepocas,tol,beta);
[ W, b, erroEpoca] = treina_adaline(W,b,X,Yd,alfa,maxepocas,tol);

plot(erroEpoca_m);
hold on;
plot(erroEpoca);
title('Comparação "Com Tx Momentum" vs "Sem Tx Momentum"');
xlabel('Épocas');
ylabel('SEQ');
legend({'Erro Epoca com Momentum', 'Erro Epoca sem Momentum'});
%
%Xs = [0 : 0.1 : 10];
%Ys = yadaline(W, b, Xs);

%hold on
%plot(Xs, Ys, '-');
%title('Geração de dados e aprendizado Adaline');
%xlabel('X');
%ylabel('Y');
%legend({'Dados', 'Função aprendida'});