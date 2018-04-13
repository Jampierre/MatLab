%
%
%
%
seg = 10;

nc  = 3;
npc = [ 100  100  100];
%mc  = [ 6  0  0
%        10  0  10
%      ];
  
mc  = [ 4  0  0
        5  0  5
      ];
  
varc =[ 1  1  1
        1  1  1
      ];
  
[X, C] = geragauss( nc, npc, mc, varc );
[X, C] = mistura(X, C);
hold on
ylim([-10 20]);
plotadc2d(X, C);
title('Dados e respectivas classifica��es');
xlabel('X1');
ylabel('X2');
pause(seg);

tol = 0;
maxepocas = 500;
alfa = 0.8;
W = rand(3, size(X, 1));
b = ones(1, size(W, 1));
sizeErroEpoca = maxepocas;
erroEpoca = zeros(3, sizeErroEpoca);
intervalo = [-5 10];

Yd = converte_dec_bin(C);
for i=1:size(W, 1) 
    [ W(i, :), b(i), x] = treina_perceptron(W(i, :), b(i), X, Yd(i, :), alfa, maxepocas, tol);
    erroEpoca(i, :) = horzcat(x, zeros(1, sizeErroEpoca - length(x))); 
    plotareta( W(i, :), b(i), intervalo )
end;
title('Dados e respectivas classifica��es');
xlabel('X1');
ylabel('X2');
pause(seg);

hold off
epocasRodadas = sizeErroEpoca;
for i=1:size(erroEpoca, 2)
    if erroEpoca(1, i) == 0 && erroEpoca(2, i) == 0 && erroEpoca(3, i) == 0
        epocasRodadas = i;
        break;
    end
end

for i=1:size(erroEpoca, 1)
    plot(erroEpoca(i, 1:epocasRodadas));
    hold on
end
title('Erros x �pocas');
xlabel('�pocas');
ylabel('SEQ');
legend({'Perceptron 1', 'Perceptron 1', 'Perceptron 3'});
pause(seg);


%reclassifica
y = [];
for i=1:size(W, 1) 
    [ y(i, :), u] = yperceptron(W(i, :), b(i), X);
end;

%plota
hold off
RC = converte_bin_dec(y);
for i=1:size(W, 1) 
    plotareta( W(i, :), b(i), intervalo )
    hold on
end
title('Dados reclassificados');
xlabel('X1');
ylabel('X2');

ylim([-10 20]);
plotadc2d(X, RC);