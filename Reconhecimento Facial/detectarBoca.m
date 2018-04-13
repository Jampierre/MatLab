% O resultado da função é a imagem 'nomeImagem com os lábios delimitados
% por um retângulo azul.
function [] = detectarBoca(nomeImagem)

imagem = imread(strcat(nomeImagem, '.jpg'));
linhasImagem = size(imagem, 1);
colunasImagem = size(imagem, 2);

R = double(imagem(:, :, 1))/255;
G = double(imagem(:, :, 2))/255;
B = double(imagem(:, :, 3))/255;

Cb = -0.14713*R - 0.28886*G + 0.436*B;
Cr = 0.615*R - 0.51498*G - 0.10001*B;

linhasBoca = 10;
colunasBoca = 50;

% Encontra a área
% comprimento com
bocaX = 1;
bocaY = 1;
maiorSoma = 0;
for i=int32(1.2*linhasImagem/3):linhasImagem-linhasBoca
    for j=1:colunasImagem-colunasBoca
        recorteFaceCb = Cb(i:i+linhasBoca, j:j+colunasBoca); recorteFaceCr = Cr(i:i+linhasBoca, j:j+colunasBoca); 
        somaRecorte = recorteFaceCb+recorteFaceCr;
        if (sum(sum(somaRecorte)) > maiorSoma)
            bocaX = i;
            bocaY = j;
            maiorSoma = sum(sum(somaRecorte));
        end
    end
end
imagemBoca = imagem;

% Desenha a um retângulo azul na área dos lábios
shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom',...
                                     'CustomBorderColor', uint8([0 0 255])); 
retangulo = int32([bocaX bocaY linhasBoca colunasBoca]);
imagem = step(shapeInserter, imagem, retangulo);
imwrite(imagemBoca, strcat(nomeImagem, '_Boca.jpg')); 
limiteInferior = bocaX + 15;
if (limiteInferior > linhasImagem)
    limiteInferior = linhasImagem;
end
imagemDelimitadaAbaixo = imagem(1:limiteInferior,:,:); 
imwrite(imagemDelimitadaAbaixo, strcat(nomeImagem, ...
                                '_BocaDelimitada.jpg'));                            
end