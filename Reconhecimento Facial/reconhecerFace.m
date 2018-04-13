% A função identifica os idivíduos calculando o desvio padrão da
% diferença entre a face de entrada 'nomeImagem' e todas as médias
% calculadas para cada indivíduo. A função retorna os dois menores
% valores para o desvio padrão e o número das faces correspondentes. 
function [numeroDaFace1, numeroDaFace2, menorValor, segundoMenorValor] = reconhecerFace(nomeImagem)
face = imread(strcat(nomeImagem, '.jpg')); R = double(face(:, :, 1))/255;
G = double(face(:, :, 2))/255;
B = double(face(:, :, 3))/255;
Y = (0.299*R + 0.587*G + 0.114*B);
U = -0.14713*R - 0.28886*G + 0.436*B;
V = 0.615*R - 0.51498*G - 0.10001*B;
vetorDesvioPadrao = zeros(28,1);
% Calcula o desvio padrão corespondente aos 28 indivíduos do banco de % dados
for i=1:28
faceMedia = imread(strcat('Faces3\media_', int2str(i), '.jpg')); mediaR = double(faceMedia(:, :, 1))/255;
mediaG = double(faceMedia(:, :, 2))/255;
mediaB = double(faceMedia(:, :, 3))/255;
mediaY = (0.299*mediaR + 0.587*mediaG + 0.114*mediaB); mediaU = -0.14713*mediaR - 0.28886*mediaG + 0.436*mediaB; mediaV = 0.615*mediaR - 0.51498*mediaG - 0.10001*mediaB; diferencaY = Y-mediaY;
    diferencaU = U-mediaU;
    diferencaV = V-mediaV;
    vetorDiferencaY = reshape(diferencaY, ...
[size(diferencaY,1)*size(diferencaY, 2),1]); vetorDiferencaU = reshape(diferencaU, ...
[size(diferencaU,1)*size(diferencaU, 2), 1]); vetorDiferencaV = reshape(diferencaV, ...
[size(diferencaV,1)*size(diferencaV, 2), 1]); vetorDesvioPadrao(i) = std(vetorDiferencaU)+std(vetorDiferencaV);
end
% Encontra os dois menores valores para o desvio padrão.
% Considera-se que, quanto menor for o desvio padrão, maior será a
% probabilidade de a face de entrada pertencer ao indivíduo correpondente % àquele desvio padrão.
menorValor = min(vetorDesvioPadrao);
numeroDaFace1 = find(vetorDesvioPadrao == menorValor); vetorDesvioPadrao(numeroDaFace1) = Inf;
segundoMenorValor = min(vetorDesvioPadrao);
numeroDaFace2 = find(vetorDesvioPadrao == segundoMenorValor);
end