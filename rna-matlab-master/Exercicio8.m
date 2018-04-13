clear all;
close all;
clc;

nc  = 5;
npc = [ 100  100  100 100 100];
mc  = [ 4  0  0  4  8 
        5  0  5  0  0
      ];
  
varc =[ 1  1  1 1 1 
        1  1  1 1 1
      ];
 
total = sum(npc);  
  
% a - crie várias amostras de dados de duas dimensões divididas em 5 
% classes não linearmente separáveis; utilize a função geragauss já criada;
[X, C] = geragauss( nc, npc, mc, varc );

% j - repita 10 vezes o procedimento a partir do item b, de modo a 
% calcular a média e desvio padrão do resultado final;
times = 10;

for i=1:times
    % b - embaralhe os dados criados; utilize a função mistura já criada;
    [X, C] = mistura(X, C);

    % c - plote os dados criados; utilize a função plotadc2d já criada;
    figure;
    hold on
    plotadc2d(X, C);

    % e - separe os dados em dois conjuntos: 
    % treinamento (80%) e teste (20%);
    treinamento     = X(:, 1:(total * 0.8)); % 80% para treinamento
    ctreinamento    = C(:, 1:(total * 0.8));
    teste           = X(:, (total * 0.8 + 1):total); % 20% para teste
    cteste          = C(:, (total * 0.8 + 1):total);

    figure
    hold on
    % f - plote os dados separados em treinamento e teste (2 gráficos 
    % separados); utilize a função plotadc2d e convbindec já desenvolvidas;
    plotadc2d(treinamento, ctreinamento);
    
    figure
    hold on
    plotadc2d(teste, cteste);

    % d - crie a matriz de classificação binária (saída desejada);
    % utilize a função convdecbin já desenvolvida;
    ctreinamento = converte_dec_bin(ctreinamento);
    cteste = converte_dec_bin(cteste);

    % g - crie uma rede neural tipo MLP e treine com o conjunto de dados de 
    % treinamento; utilize as funções do toolbox ANN do MATLAB;
    net = feedforwardnet([10 10 10]);
    [net, tr] = train(net, treinamento, ctreinamento);
    Ys = sim (net, teste);

    % i - reclassifique os dados do conjunto de treinamento e teste 
    % utilizando a RNA treinada (utilize o toolbox) e contabilize o número 
    % de acertos (resposta em porcentagem de acertos separado 
    % para treinamento e teste);
    Yt = sim (net, treinamento);
    Ct = round(Yt) == ctreinamento;
    Et(i) = sum(sum(Ct)) / total / 100;
    
    Ytt = sim(net, teste);
    Ctt = round(Ytt) == cteste;
    Ett(i) = sum(sum(Ctt)) / total / 100;
end
    
% h - plote o erro médio quadrático de treinamento por época;
plotperform(tr);

media_Et  = mean(Et); 
media_Ett = mean(Ett);

std_Et = std(Et);
std_Ett = std(Ett);

% l - plote os dados de treinamento e teste reclassificados pela RNA 
% (gráficos separados) e compare, graficamente, com a classificação 
% original.
figure
hold on
plotadc2d(teste, converte_bin_dec(round(Ys)));

figure 
hold on
plotadc2d(treinamento, converte_bin_dec(round(Yt)));

