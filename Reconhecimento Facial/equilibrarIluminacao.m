% Essa função tem como entrada uma imagem de 100x100 e a saída é a imagem % de entrada após a alteração da iluminação.
function [imagem] = equilibrarIluminacao( nomeImagem )
% Lê a imagem de entrada
imagem = imread(strcat(nomeImagem,'.jpg'));
% Converte as matrizes de cores no
% intervalo [0,1]
R = double(imagem(:, :, 1))/255;
G = double(imagem(:, :, 2))/255;
B = double(imagem(:, :, 3))/255;
% Encontra as componentes de cores do no espaço YCbCr
Y = (0.299*R + 0.587*G + 0.114*B);
U = -0.14713*R - 0.28886*G + 0.436*B;
V = 0.615*R - 0.51498*G - 0.10001*B;
% Lê a matriz resultante da iluminação média de 8 imagens do banco de dados
media = dlmread('media2.txt');
Y = Y*0.5 + media*0.5;
% Converte as matrizes encontradas novamente para o espaço RGB
R = (Y + 1.13983*V)*255;
G = (Y -0.39465*U - 0.58060*V)*255;
B = (Y + 2.03211*U)*255;
imagem(:,:,1) = R;
imagem(:,:,2) = G;
imagem(:,:,3) = B;
% Armazena a imagem resultante
imwrite(imagem, strcat(nomeImagem, 'Y.jpg')); 
end