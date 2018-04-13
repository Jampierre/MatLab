% A função retorna a posição dos dois olhos encontrados em
% 'nomeImagem'
function [olhoEsquerdoX, olhoEsquerdoY, olhoDireitoX, olhoDireitoY] = detectarOlhos3(nomeImagem)
% Abre a imagem
imagem = imread(strcat(nomeImagem, '.jpg')); linhasImagem = size(imagem, 1); colunasImagem = size(imagem, 2);
R = double(imagem(:, :, 1))/255;
G = double(imagem(:, :, 2))/255;
B = double(imagem(:, :, 3))/255;
Y = 0.299*R + 0.587*G + 0.114*B;
U = -0.14713*R - 0.28886*G + 0.436*B;
V = 0.615*R - 0.51498*G - 0.10001*B;
% Calcula a matriz com todos os ângulos entre os pixels vizinhos % horizontais da imagem
matrizAngulos = zeros(int32(linhasImagem/2), colunasImagem-1); for i=1:int32(linhasImagem/2)
for j=1:colunasImagem-1
matrizAngulos(i,j) = anguloEntreVetores(imagem(i,j,:),imagem(i,j+1,:));
end
end
% Define as dimensões do retângulo da área dos olhos
linhasOlho = 5;
colunasOlho = 30;
linhaInicial = 1 + int32((linhasImagem/2)*0.3);
linhaFinal = int32(linhasImagem/2) - int32((linhasImagem/2)*0.1);
% Encontra o olho esquerdo
olhoEsquerdoX = 1;
olhoEsquerdoY = 1;
maiorSomaU = sum(sum(U(1:1+linhasOlho, 1:1+colunasOlho))); maiorSomaAngulos = 0;
for i=linhaInicial:linhaFinal-linhasOlho
for j=1:int32(colunasImagem/2)-colunasOlho recorteFaceU = U(i:i+linhasOlho, j:j+colunasOlho); somaRecorteU = sum(sum(recorteFaceU));
somaAngulos = sum(sum(matrizAngulos(i:i+(linhasOlho-2), ... 
    j:j+(colunasOlho-2))));
if ((somaRecorteU > maiorSomaU && somaAngulos > ... 
    0.9*maiorSomaAngulos) || (somaAngulos > maiorSomaAngulos)) olhoEsquerdoX = i;
olhoEsquerdoY = j;
maiorSomaU = somaRecorteU;
maiorSomaAngulos = somaAngulos;
end
end
end
% Desenha na imagem um retângulo azul na posição dos olho esquerdo
shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom', ...
'CustomBorderColor', uint8([0 0 255])); retangulo = int32([olhoEsquerdoX olhoEsquerdoY linhasOlho ...
colunasOlho]);
imagem = step(shapeInserter, imagem, retangulo);
% Encontra o olho direito
olhoDireitoX = 1;
olhoDireitoY = 1;
maiorSomaU = sum(sum(U(1:1+linhasOlho, int32(colunasImagem/2):int32(colunasImagem/2)+colunasOlho))); maiorSomaAngulos = 0;
for i=linhaInicial:linhaFinal-linhasOlho
for j=int32(colunasImagem/2):colunasImagem-colunasOlho recorteFaceU = U(i:i+linhasOlho, j:j+colunasOlho); somaRecorteU = sum(sum(recorteFaceU));
somaAngulos = sum(sum(matrizAngulos(i:i+(linhasOlho-2), ... 
    j:j+(colunasOlho-2))));
if ((somaRecorteU > maiorSomaU && somaAngulos > ... 
        0.9*maiorSomaAngulos) || (somaAngulos > maiorSomaAngulos)) olhoDireitoX = i;
olhoDireitoY = j;
maiorSomaU = somaRecorteU;
maiorSomaAngulos = somaAngulos;
end
end
end
% Desenha na imagem um retângulo azul na posição dos olho direito
shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom', ...
'CustomBorderColor', uint8([0 0 255]));
retangulo = int32([olhoDireitoX olhoDireitoY linhasOlho colunasOlho]);
imagem = step(shapeInserter, imagem, retangulo);
% Desenha na imagem as linhas que delimitam o espaço de busca do algoritmo
for i=1:colunasImagem
    imagem(linhaInicial, i, 1) = 255;
    imagem(linhaInicial, i, 2) = 0;
    imagem(linhaInicial, i, 3) = 0;
    imagem(linhaFinal, i, 1) = 255;
    imagem(linhaFinal, i, 2) = 0;
    imagem(linhaFinal, i, 3) = 0;
end
% Salva a imagem com os olhos detectados
imwrite(imagem, strcat(nomeImagem, '_olhos.jpg')); 
end