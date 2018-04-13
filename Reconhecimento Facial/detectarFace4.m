% A função retorna a localização da face na imagem
function[faceX,faceY,linhasFace,colunasFace]=detectarFace4(nomeImagem)

%imagem = imread(strcat(nomeImagem, '.jpg'));
imagem = nomeImagem;

%[linhasImagem,colunasImagem] = size(imagem);
linhasImagem = size(imagem, 1);
colunasImagem = size(imagem, 2);

% Aplica a rede neural à todos os pixels da imagem de entrada para a 
% segmentação de pele
matrizPeleSegmentada = aplicarRedeNeural2(nomeImagem);

% Inicialmente, considera-se um retangulo com 200 linhas e 120 colunas % para deleimitar a face.
linhasFace = 200;
colunasFace = 120;

% Procura o retângulo com o maior valor para a soma dos seus pixels.
faceX = 1;
faceY = 1;
maiorSoma = 0;
for i=1:linhasImagem-linhasFace
    for j=1:colunasImagem-colunasFace
        recorte= matrizPeleSegmentada(i:i+linhasFace,j:j+colunasFace);
        if (sum(sum(recorte)) > maiorSoma)
            faceX = i;
            faceY = j;
            maiorSoma = sum(sum(recorte));
        end
    end
end

media = mean(mean(matrizPeleSegmentada(faceX:faceX+linhasFace,faceY:faceY+colunasFace, :)));

% Delimita ainda mais o rosto à esquerda.
% Percorre o retângulo da esquerda para a direita eliminando as
% colunas nas quais a soma dos pixels seja inferior à um valor de
% corte.
for j=faceY:faceY + colunasFace/2
    if (sum(matrizPeleSegmentada(faceX:faceX+linhasFace, j, 1)) < ...
                                        0.7*media*(linhasFace))
        faceY = faceY+1;
        colunasFace = colunasFace-1;
    else
        break;
    end
end

% Delimita ainda mais o rosto à direita
% Percorre o retângulo da direita para a esquerda eliminando as
% colunas nas quais a soma dos pixels seja inferior à um valor de 
% corte.
for j=faceY+colunasFace:-1:faceY+colunasFace/2
    if (sum(matrizPeleSegmentada(faceX:faceX+linhasFace, j, 1)) < ...
                                        0.7*media*(linhasFace))
        colunasFace = colunasFace-1;
    else
        break;
    end
end

% Delimita o rosto em cima
% Percorre o retângulo de cima para baixo eliminando as linhas nas
% quais a soma dos pixels seja inferior à um valor de corte.
for j=faceX:faceX + linhasFace/2
    if (sum(matrizPeleSegmentada(j, faceY:faceY+colunasFace, 1)) < ...
                                        0.7*media*(colunasFace))
        faceX = faceX+1;
        linhasFace = linhasFace - 1;
    else
        break;
    end
end

% Delimita o rosto em baixo
% Percorre o retângulo de baixo para cima eliminando as linhas nas
% quais a soma dos pixels seja inferior à um valor de corte.
for j=faceX + linhasFace:-1: faceX + linhasFace/2
    if (sum(matrizPeleSegmentada(j, faceY:faceY+colunasFace, 1)) < 0.7*media*(colunasFace))
        linhasFace = linhasFace - 1;
    else
        break;
    end
end

% Cria uma nova imagem com apenas o 'rosto' detectado na imagem
% original
imagemColorida = imagem(faceX:faceX+linhasFace, ...
                        faceY:faceY+colunasFace, :); 
colunasImagem = size(imagemColorida,2);
escala = 100/colunasImagem;
imagemColorida = imresize(imagemColorida, escala);
imwrite(imagemColorida, strcat(nomeImagem, ...
                            '_faceRecorte4Delimitado.jpg'));
imwrite(matrizPeleSegmentada(faceX:faceX+linhasFace, ...
                        faceY:faceY+colunasFace, :), strcat(nomeImagem, ...
                        '_faceRecorte4DelimitadoBW.jpg'));
end
