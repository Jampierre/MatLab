% Essa função tem como entrada o nome de uma imagem com uma face delimitada % e retorna a imagem de entrada com as regiões dos olhos delimitadas por
% retângulos com bordas azuis.
function [imagemOlhos] = detectarOlhos4(nomeimagemOlhos)
% Lê a imagem de entrada
imagemOlhos = imread(strcat(nomeimagemOlhos, '.jpg')); linhasimagemOlhos = size(imagemOlhos, 1); colunasimagemOlhos = size(imagemOlhos, 2);
% Converte os valores em RGB para valores no intervalo [0,1]
R = doule(imagemOlhos(:, :, 1))/255; G = double(imagemOlhos(:, :, 2))/255; B = double(imagemOlhos(:, :, 3))/255;
% Encontra a matriz Cb da imagem, que será a única a ser utilizada pelo % algoritmo
Cb = -0.14713*R - 0.28886*G + 0.436*B;
% As regiões dos olhos serão delimitadas por retângulos de 20x10 pixels
linhasOlho = 10;
colunasOlho = 20;
% Procura a região do olho esquerdo
olhoEsquerdoX = 1;
olhoEsquerdoY = 1;
maiorSoma = sum(sum(Cb(1:1+linhasOlho, 1:1+colunasOlho)));
% Percorre a metade vertical esquerda da face de modo a procurar um
% retângulo com uma área de 20x10 pixels com o maior valor para a soma dos % valores de Cb de cada pixel
for i=1:int32(linhasimagemOlhos/2)-linhasOlho
for j=1:int32(colunasimagemOlhos/2)-colunasOlho recorteFace = Cb(i:i+linhasOlho, j:j+colunasOlho); somaRecorte = sum(sum(recorteFace));
if (somaRecorte > maiorSoma)
    olhoEsquerdoX = i;
olhoEsquerdoY = j;
maiorSoma = somaRecorte;
end
end
end
% Desenha na imagemOlhos um retângulo azul na posição dos olho esquerdo
shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom', 'CustomBorderColor', uint8([0 0 255]));
retangulo = int32([olhoEsquerdoX olhoEsquerdoY linhasOlho colunasOlho]); imagemOlhos = step(shapeInserter, imagemOlhos, retangulo);
retangulo = int32([olhoEsquerdoX-1 olhoEsquerdoY-1 linhasOlho+2 colunasOlho+2]);
imagemOlhos = step(shapeInserter, imagemOlhos, retangulo);
% Procura a região do olhos direito
olhoDireitoX = 1;
olhoDireitoY = int32(colunasimagemOlhos/2);
maiorSoma = sum(sum(Cb(1:1+linhasOlho, int32(colunasimagemOlhos/2):int32(colunasimagemOlhos/2)+colunasOlho)));
% Percorre a metade vertical direita da face de modo a procurar um
% retângulo com uma área de 20x10 pixels com o maior valor para a soma dos % valores de Cb de cada pixel
for i=1:int32(linhasimagemOlhos/2)-linhasOlho
for j=int32(colunasimagemOlhos/2):colunasimagemOlhos-colunasOlho recorteFace = Cb(i:i+linhasOlho, j:j+colunasOlho); somaRecorte = sum(sum(recorteFace));
if (somaRecorte > maiorSoma)
    olhoDireitoX = i;
olhoDireitoY = j;
maiorSoma = somaRecorte;
end
end
end
% Desenha na imagemOlhos um retângulo azul na posição dos olho direito
shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom', 'CustomBorderColor', uint8([0 0 255]));
retangulo = int32([olhoDireitoX olhoDireitoY linhasOlho colunasOlho]); imagemOlhos = step(shapeInserter, imagemOlhos, retangulo);
retangulo = int32([olhoDireitoX-1 olhoDireitoY-1 linhasOlho+2 colunasOlho+2]);
imagemOlhos = step(shapeInserter, imagemOlhos, retangulo);
% Armazena o resultado em um arquivo de imagem
imwrite(imagemOlhos, strcat(nomeimagemOlhos, '_olhos.jpg')); 
end