function [Is] = convolucion(I, masc, n)
[mf, nc, x] = size(I);
Is = zeros(mf,nc);
if x ~= 1
    I = rgb2gray(I);  % convertir si no es rgb
end
if n >= 3
    masc = ones(n)*(1/n);  % crear mascara de tamaño n
else
    [n, x] = size(masc);
end

n1 = round(n/2)-1;

It = zeros(mf+2*n1, nc+2*n1);  % matriz llenar la imagen y ampliarla
It(1:1:n1, n1+1:1:nc+n1) = I(1:1:n1, 1:1:nc);  % arriba
It(mf+n1:1:mf+2*n1, n1+1:1:nc+n1) = I(mf-n1:1:mf, 1:1:nc);  % abajo
It(n1:1:mf+n1-1, 1:1:n1) = I(1:1:mf, 1:1:n1);  % izquierda
It(n1:1:mf+n1-1, nc+n1+1:1:nc+2*n1) = I(1:1:mf, nc-n1+1:1:nc);  % derecha
It(n1:1:mf+n1-1, n1+1:1:nc+n1) = I;  % centro
% It(2*n1+1:1:mf+2*n1, 2*n1+1:1:nc+2*n1) = I; % esquina inferior 
A = zeros(n,n);  % matriz para obtener recuadros de la imagen ampliada
for i = n1: mf+n1-1
    for j = n1+1: nc+n1
       A = It(i-n1+1:i+n1+1,j-n1:j+n1); % apartar cuadro de imagen ampliada
       sum = 0;
       for k = 1: n
           for l = 1: n
               sum = (A(k, l)* masc(n-k+1,n-l+1))+sum; % oprecion conv
           end   
       end
       Is(i-n1+1,j-n1+1) = sum; % pixel de salida
    end
end
Is = uint8(escalar(Is,255));  %regresar valor a escala de gris 255
end