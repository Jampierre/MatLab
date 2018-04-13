    function [W,b,Erroepocas] = treina_perceptron(W, b, Xin, Yin, alfa, maxepocas, tol)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      26/10/2017

% Algoritmo de treinamento do Perceptron

% usar a funçano rend para gerar valore de -1 e 1 para W
% o b tbmé um numero aleatorio entre -1 e 1
% Xin [0 1 0 1; 0 0 1 1 ]
% Yin é o valor de saida desejado [ 0 0 0 1 ]
% alfa 1.2 ( depois testar outros valores) valor nao pode ser mt baixo se
% nao o treinamdno vai demorar d+ e nem muito alto se nao o valor n
% converge 
% max de epoca é em torno de 10
% tolerancia o erro pode ser bem pequeno como zero. Suguestao inicial é
% 0.001

%Somatorio dos erros quadrados para prlotar o ERROEPOCA

%W = matriz (k x m) de pesos; para apenas um neurônio k = 1
% b = vetor (k x 1) com valor do bias de cada neurônio
% Xin = matriz (m x t) com as amostras dos dados em colunas
% Yin = matriz (k x t) com as saidas desejadas para cada amostra de dados
% k = número de neurônios
% m = número de entradas de cada neurônio (dimensão dos dados)
% t = número de amostras dos dados
% alfa = taxa de correção do peso; taxa de aprendizagem
% maxepocas = valor máximo de épocas de treinamento
% tol = erro máximo tolerável
% Erroepoca = matriz (k x maxepocas) com todos os erros quadráticos
%acumulados durante aprendizado de cada neurônio

t = 1;
Erroepocas = [];
[ln cl] = size(Xin);
while (t < maxepocas) && (tol > 0)
    seg = 0;
    for i=1:cl
        y = yperceptron(Xin(:,i),W,b);
        e = Yin(i) - y;
        W = W + alfa * e * Xin(:,i)';
        b = b + alfa * e;
        seg = seg + e.^2;
    end
    Erroepocas = [Erroepocas seg];
    t = t + 1;
end

end

