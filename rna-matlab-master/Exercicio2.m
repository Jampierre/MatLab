

X = [0 1 0 1 ; 0 0 1 1];
Yd = [0 0 0 1];
alfa = 1.2;
maxepocas = 10;
tol = 0.001;
W = rand(1,2);
b = rand(1,1);

[w, b, erroEpoca] = treina_perceptron(W, b, X, Yd, alfa, maxepocas, tol);

w
b
yperceptron(w, b, X)
plot(erroEpoca);
xlabel('Epocas');
ylabel('SEQ');
title('Convergência AND');