%
%
%
%
%
%

seg = 1;
nc  = 2;
npc = [ 100  100  ];
mc  = [ 5  2  
        5  2  
      ];
varc =[ 0.5  0.75 
        0.5  0.75  
      ];

[X, C] = geragauss( nc, npc, mc, varc );

hold on
plotadc2d(X, C);
pause(seg);

[X, C] = mistura(X, C);
hold on
plotadc2d(X, C);
pause(seg);
hold on

W = rand(1, size(X, 1));
b = rand();
Yd = C;
alfa = 0.0009;
maxepocas = 20;
tol = 0;
[W, b, erroEpoca] = treina_perceptron(W,b,X,Yd,alfa,maxepocas,tol);

plotareta(W, b, [-2 4]);
hold off
pause (seg);
[y, u] = yperceptron(W, b, X);

clf;
hold on
plotadc2d(X, y);
plotareta(W, b, [-2 4]);
pause (seg);

hold off
plot(erroEpoca)
xlabel('Épocas')
ylabel('SEQ')
title('Gráfico SEQ')