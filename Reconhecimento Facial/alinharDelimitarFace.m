% Essa função tem como entrada uma imagem com a face delimitada, a imagem
% original da face delimitada e o número da imagem no banco de dados.
% A saída dessa função é a face alinhada e delimitada acima dos olhos.
function [imagemAlinhada] = alinharDelimitarFace(nomeImagem,nomeImagemOriginal,numeroImagem)

% Lê a imagem com a face delimitada
imagem = imread(strcat(nomeImagem, '.jpg'));

% Enocntra a posição dos olhos a partir do resultado do Algoritmo de % Localição de Olhos III
[olhoEsquerdoX, olhoEsquerdoY, olhoDireitoX, olhoDireitoY] = detectarOlhos3(nomeImagem);
linhasOlho = 5;
colunasOlho = 30;

% Coordenadas dos olhos no plano cartesiano
x1 = olhoEsquerdoY + (linhasOlho/2);
x2 = olhoDireitoY + (linhasOlho/2);
y1 = olhoEsquerdoX + (colunasOlho/2);
y2 = olhoDireitoX + (colunasOlho/2);

% Calcula o ângulo da reta que passa pelos pontos centrais das regiões dos % olhos
inclinacaoDaReta = double(y1-y2)/double(x1-x2);
angulo = (atan(double(inclinacaoDaReta))/pi)*180;

% Abre o arquivo no qual foram armazenadas as posições das faces em cada
% imagem do banco de dados a partir do Algoritmo de Localização de Face IV matrizPosicoes = dlmread('matrizResultadosTeste.txt');
faceX = matrizPosicoes(numeroImagem, 1);
faceY = matrizPosicoes(numeroImagem, 2);
linhasFace = matrizPosicoes(numeroImagem, 3);
colunasFace = matrizPosicoes(numeroImagem, 4);

% Lê a imagem original do banco de dados
imagemOriginal = imread(strcat(nomeImagemOriginal, '.jpg'));

% Rotaciona a imagem original de acordo com o ângulo encontrado
% Considerou-se apenas os ângulos entre 5o e 15o, pois, caso o ângulo seja 
% menor do que 5 o resultado do alinhamento será sutil, e caso o ângulo
% seja maior do que 15, há uma probabilidade maior de que o resultado da
% localização dos olhos esteja errado.
if (abs(angulo) > 5 && abs(angulo)<15)
    imagemOriginalRotacionada = imrotate(imagemOriginal, angulo);
else
    imagemOriginalRotacionada = imagemOriginal;
end

% Armazena a imagem original rotacionada.
imwrite(imagemOriginalRotacionada, strcat(nomeImagem, '_rotacionado.jpg')); 
faceX = faceX + int32(((size(imagemOriginalRotacionada,1)) - (size(imagemOriginal,1)))/2);
faceY = faceY + int32(((size(imagemOriginalRotacionada,2)) - (size(imagemOriginal,2)))/2);

% Delimita a imagem original rotacionada a partir da posição da face % encontrada em 'matrizPosicoes'
imagemResultante = imagemOriginalRotacionada(faceX:faceX+linhasFace,faceY:faceY+colunasFace, :);
escala = 100/(colunasFace+1);
imagemResultante = imresize(imagemResultante, escala);
imwrite(imagemResultante, strcat(nomeImagem, '_alinhado.jpg'));

% Delimita a face resultante
linhaDosOlhos = abs(min([olhoEsquerdoX, olhoDireitoX]) - 10);

% Armazena a imagem alinhada e delimitada acima dos olhos
imagemAlinhada = imagemResultante(linhaDosOlhos:size(imagemResultante,1), :, :);
imwrite(imagemAlinhada, strcat(nomeImagem, '_alinhadoCortado.jpg'));

end