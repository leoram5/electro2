function [Is] = ecualizar_imagen1(I)
[mf, nc, pp] = size(I);  % tamaño de la imagen
if pp == 3
    I = rgb2gray(I);  % Convertir imagen a escala de gris.
end
h = imhist(I);  %histograma.
L = 0:255;  %niveles de gris.
P = h/(mf*nc);  %probalidades de los nivels de gris.
T = cumsum(P);  %suma acomulada de probabilidades.
Is = zeros(mf, nc);
%  crear histograma
ld = 0:255;
for i = 1 : ld(end)+1
    Td(i) = sqrt(ld(i))-log(1+ld(i));% puede ser cualquier curva.
end
Td = escalar(Td,255); 
%
for i = 1: mf
    for j = 1: nc
        pix = round(T(I(i, j) +1)*255);
        aux = abs(Td - pix);
        pix = min(aux);
        Is(i,j) = mean(find(aux==pix));
    end
end
Is = uint8(escalar(Is,255));
T = escalar(T,255);
plot(L,T,ld,Td);
grid("on");
legend("Ecualizacion normal.","funcion implementada manualmente.");
title("Suma acomulada: $(T)$ Vs tono de gris: $(L_o)$",LineWidth = 3,Interpreter="latex");
ylabel("$T$",LineWidth = 3,Interpreter="latex");
xlabel("$L$",LineWidth = 3,Interpreter="latex");
xlim([0 257]);
ylim([0 257]);

end 