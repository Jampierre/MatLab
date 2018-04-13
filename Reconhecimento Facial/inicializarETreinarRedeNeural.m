% Função utilizada para treinar a rede neural que será utilizada na
% segmentação de pele
function [] = inicializarETreinarRedeNeural( )

% A matriz de entrada corresponde ao conjunto de todos os pixels das 40
% imagens utilizadas no treinamento da rede.
matrizEntrada = dlmread('matrizEntrada.txt');

% A matriz de saída contém os valores de saída esperados para o conjunto de
% entrada
matrizSaida = dlmread('matrizSaida.txt');

% Cria uma rede do tipo Feedforward com duas camadas ocultas, uma com cinco
% e outra com três neurôniios.
net6 = feedforwardnet([5 3],'trainbr');
net6.divideParam.trainRatio = 1; % training set [%]
net6.divideParam.valRatio = 0; % validation set [%]
net6.divideParam.testRatio = 0; % test set [%]
net6.trainParam.epochs = 100; % número de épocas de treinamento
tamanhoCadaImagem = 132608;
net6 = train(net6,matrizEntrada',matrizSaida');
view(net6)
save('net6.mat', 'net6'); % armazena a rede treinada em 'net6.mat'
end