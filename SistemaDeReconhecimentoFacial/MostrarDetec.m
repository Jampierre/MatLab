function MostrarDetec(image, faces)
%Mostra na imagem de entrada, as regiões classificadas corretamente
%Entrada --> image: Imagem Original
%            faces: Vetor com as coordenadas das regiões com faces
figure;
imshow(image);
k = size(faces,1);
hold on;
for i=1:k
    rectangle('Position', faces(i,:),'LineWidth',3,'EdgeColor', 'w');
end
hold off;