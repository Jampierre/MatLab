% Esta função retorna uma matriz em escala de cinza resultante da aplicação
% da rede neural na imagem 'nomeImagem'. Quando mais próximos da cor
% branca, maior a probabilidade de um pixel pertencer à região da pele
function [matrizEscalaDeCinza] = aplicarRedeNeural2(nomeImagem)

% net6 é a rede treinada para segmentar a pele em imagens coloridas
load net6;
imagem = imread(strcat(nomeImagem, '.jpg'));
linhas = size(imagem, 1);
colunas = size(imagem, 2);
matriz1 = reshape(imagem(:,:,1), [size(imagem,1)*size(imagem, 2), 1]);
matriz2 = reshape(imagem(:,:,2), [size(imagem,1)*size(imagem, 2), 1]);
matriz3 = reshape(imagem(:,:,3), [size(imagem,1)*size(imagem, 2), 1]);
matrizEntrada = [matriz1 matriz2 matriz3];

% A função sim do Matlab aplica uma rede neural à um conjunto de dados
resultado = sim (net6 , double(matrizEntrada)');
matrizEscalaDeCinza = abs(resultado);
matrizEscalaDeCinza = reshape(matrizEscalaDeCinza, linhas, colunas); 
imwrite(matrizEscalaDeCinza, strcat(nomeImagem, '_RN2.jpg'));
end