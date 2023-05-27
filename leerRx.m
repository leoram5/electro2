function [I] = leerRx(n,lista)
if lista == 1;
    arc = dir('Rx_torax\pneumonia/*.png');
    nam="Rx_torax\pneumonia";
end
if lista == 2;
    arc = dir('Rx_torax\sanos/*.png');
    nam="Rx_torax\sanos";
end
[n1, x] = size(arc); 
if (n > n1)
    n = n1;
end
for i = 1:n
    nombre_archivo = arc(i).name;
    I{i} = imread(fullfile(nam, nombre_archivo));   
end
%I=double(I);
end