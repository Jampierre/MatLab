clear all;
close all;
clc;

% a - crie várias amostras de dados (pares x,y) segundo a função seno no intervalo de 0 a 2*?;
amostras = 0 : 0.02: 2*pi;
saida = sin(amostras);
C = saida;

plot(amostras, saida); %seno

range1 = 0 : 0.1: 2*pi;
saida_ruido = sin(range1);
saida_ruido = saida_ruido + randn(1, length(saida_ruido))*0.25;
hold on

%c - plote os dados criados; utilize a função plot do toolbox;
plot(range1, saida_ruido, 'o'); %seno

X = amostras;

% b - embaralhe os dados criados; utilize a função mistura já criada;
[X, C] = mistura(X, C);

total = length(amostras);

% d - separe os dados em dois conjuntos: treinamento (80%) e teste (20%);

% e - introduza um pequeno ruído com distribuição normal nos valores de y (saída) do 
% conjunto de dados de treinamento;
treinamento_semruido = X(:, 1:(total * 0.8)) ;
treinamento     = treinamento_semruido + randn(1, round(total * 0.8))*0.25; % 80% para treinamento
ctreinamento    = C(:, 1:(total * 0.8));
teste           = X(:, (total * 0.8 + 1):total); % 20% para teste
cteste          = C(:, (total * 0.8 + 1):total);

% f - plote os dados separados em treinamento (com ruído) e teste 
% (sem ruído); utilize a função plot do toolbox;
figure;
plot(amostras, saida);
hold on
plot(treinamento, ctreinamento, 'o');
hold on;
% plot(length(teste), teste, '*');

vezes = 10;
Ett = 100;
Melhor_rede = '';
Melhor_tr = '';

emq = [];
emp = [];
r2_ = [];

emq_tt = [];
emp_tt = [];
r2_tt = [];


dp = []; % desvio padrao

for i=1:vezes
    % g - crie uma rede neural tipo MLP e treine com o conjunto de dados 
    % de treinamento (com ruído); utilize as funções do toolbox 
    % ANN do MATLAB;

    net = feedforwardnet([5]);
    net.trainParam.epochs = 5000;
    net.trainParam.lr = 1;
    net.trainParam.max_fail = 1000;
    [net, tr] = train(net, treinamento, ctreinamento);
    
    Yt = sim (net, treinamento);
    Ys = sim (net, teste); 
    
    % h - plote o erro médio quadrático de treinamento por época; 
    
    
    % i - calcule a saída obtida pela MLP treinada: utilize como entrada 
    % os dados do conjunto de treinamento e teste (utilize o toolbox ANN) 
    % e compare com os valores desejados de saída (sem ruído tanto 
    % para treinamento quanto teste); 
    Ytt_n = sim(net, teste);
    Ctt_n = round(Ytt_n) == cteste;
    Ett_n = sum(sum(Ctt_n)) / total / 100;
    
    if (Ett_n < Ett)
        Melhor_rede = net;
        Ett = Ett_n;
        Ytt = Ytt_n;
        Ctt = Ctt_n;
        Melhor_tr = tr;
    end    
    
    % j - calcule o EMQ (erro médio quadrático), 
    % EMP (erro médio percentual) e R2 (coeficiente de determinação) 
    % separadamente para os resultados dos conjuntos de dados de 
    % treinamento e teste;
    emq(i) = mse(net, ctreinamento, Yt);
    emq_tt(i) = mse(net, cteste, Ytt_n);
    
    emp(i) = mape(ctreinamento, Yt);
    emp_tt(i) = mape(cteste, Ytt_n);
    
    r2_(i) = r2(ctreinamento, Yt);
    r2_tt(i) = r2(cteste, Ytt_n);
    % k - repita 10 vezes o procedimento a partir do item b, de modo a calcular a média e desvio padrão do EMQ, EMP e R2;

    % l - plote os dados de treinamento e teste aproximados (valor da saída) pela melhor RNA  e compare, graficamente, com a função original (sem ruído).

end

plotperform(tr);

figure;
xlabel('Titulo');
plot(amostras, saida);
hold on
plot(treinamento, Yt, '*');
hold on;
plot(teste, Ytt, 'o');
hold on;
legend({'Senoide', 'Amostras de treinamento reaplicadas', 'Saída do teste'});

