% Esta função tem como entrada uma imagem com uma face delimitada e a saída
% é a imagem de entrada com uma linha vermelha na região dos olhos.
function [imagemLinhaOlhos] = detectarOlhos1(nomeImagem)

% Lê a imagem de entrada
imagemLinhaOlhos = imread(strcat(nomeImagem, '.jpg'));

% Encontra as linhas e colunas da imagem
linhasImagem = size(imagemLinhaOlhos, 1); 
colunasImagem = size(imagemLinhaOlhos, 2);

% Calcula a soma dos ângulos de todos os pixels vizinhos horizontalmente
vetorSomaDosAngulos = [];
for i=1:(linhasImagem/2)
    somaDosAngulos = 0;
    for j=1:colunasImagem-1
        anguloEntreVetores(imagemLinhaOlhos(i,j,:), imagemLinhaOlhos(i,j+1,:));
        somaDosAngulos = somaDosAngulos + anguloEntreVetores(imagemLinhaOlhos(i,j,:),imagemLinhaOlhos(i,j+1,:));
    end
    somaDosAngulos = somaDosAngulos/(colunasImagem-1);
    vetorSomaDosAngulos = [vetorSomaDosAngulos somaDosAngulos];
end

% Percorre a primeira metade horizontal da imagem de forma a encontrar
% cinco linhas consecutivas com a maior soma total dos ângulos entre pixels % vizinhos.
linhaDosOlhos = 1;
maxSomaDosAngulos = 0;
for i = 1:(linhasImagem/2)-4
    somaDeCincoAngulos =vetorSomaDosAngulos(i) + vetorSomaDosAngulos(i+1) + vetorSomaDosAngulos(i+2)+ vetorSomaDosAngulos(i+3)+ vetorSomaDosAngulos(i+4);
    if somaDeCincoAngulos > maxSomaDosAngulos
        linhaDosOlhos = i+2;
        maxSomaDosAngulos = somaDeCincoAngulos;
    end
end

% Desenha uma linha vermelha na região dos olhos
imagemLinhaOlhos(linhaDosOlhos-1:linhaDosOlhos+1,:, 1) = 255;
imagemLinhaOlhos(linhaDosOlhos-1:linhaDosOlhos+1,:, 2) = 0;
imagemLinhaOlhos(linhaDosOlhos-1:linhaDosOlhos+1,:, 3) = 0;

% Armazena a imagem resultante
imwrite(imagemLinhaOlhos, strcat(nomeImagem, '_linhaDosOlhos.jpg'));
end

% Essa função calcula o ângulo (em graus) entre dois vetores no espaço. % Os vetores são representados por matrizes.
% As duas matrizes de entrada tem dimensões 1x1x3.
function [resultado] = anguloEntreVetores(matriz1, matriz2)
cossenoEntreVetores = produtoEscalar(matriz1, matriz2)/(moduloVetor(matriz1)*moduloVetor(matriz2));
if (cossenoEntreVetores>1)
    cossenoEntreVetores = 1;
end
resultado = (acos(double(cossenoEntreVetores))/pi)*180;
end

% Calcula o produto escalar de dois vetores no espaço. % Os vetores são representados por matrizes.
% As duas matrizes de entrada tem dimensões 1x1x3.
function [resultado] = produtoEscalar(matriz1, matriz2)
u = double([matriz1(1,1,1); matriz1(1,1,2); matriz1(1,1,3)]); 
v = double([matriz2(1,1,1); matriz2(1,1,2); matriz2(1,1,3)]); 
resultado = u'*v;
end

% Calcula o módulo de um vetor no espaço.
% Os vetores são representados por matrizes.
% As duas matrizes de entrada tem dimensões 1x1x3.
function [resultado] = moduloVetor(matriz)
u = double([matriz(1,1,1); matriz(1,1,2); matriz(1,1,3)]);
resultado = sqrt(u'*u);
end