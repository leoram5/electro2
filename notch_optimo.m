function [Iwa] = notch_optimo(Imagen,Imagenruido,regiones)
nr = regiones; 
I = Imagen;
I2 = Imagenruido;
[f, c] = size(I);
lf = round(f/nr);
lc = round(c/nr);
ci = 1;
cj = 1;
Iwa = zeros(f,c);
for i = 1: lf : f
    for j = 1: lc : c
        if (ci < nr)&(cj < nr)
            Ir =  I(i:i+lf-1,j:j+lc-1);
            I2r = I2(i:i+lf-1,j:j+lc-1); 
        elseif (ci == nr)&(cj ~= nr)&(cj<=nr)
            Ir =  I(i:end,j:j+lc-1);
            I2r = I2(i:end,j:j+lc-1);
        elseif (ci ~= nr)&(cj == nr)&(ci<=nr)
            Ir =  I(i:i+lf-1,j:end);
            I2r = I2(i:i+lf-1,j:end);
        elseif (ci == nr)&(cj == nr)
            Ir =  I(i:end,j:end);
            I2r = I2(i:end,j:end);
        end
        num1a = mean(Ir.*I2r,"all");
        num2a = mean(Ir,"all")*mean(I2r,"all");
        den1a = mean(I2r.*I2r,"all");
        den2a = mean(I2r,"all")*mean(I2r,"all");
        wa = (num1a - num2a)/(den1a-den2a);
        aux = Ir - (wa*I2r);
        aux = escalar(aux,255); 
        if (ci < nr)&(cj < nr)
            Iwa(i:i+lf-1,j:j+lc-1) = aux;
        elseif (ci == nr)&(cj ~= nr)&(cj<=nr)
            Iwa(i:end,j:j+lc-1) = aux; 
        elseif (ci ~= nr)&(cj == nr)&(ci<=nr)
            Iwa(i:i+lf-1,j:end) = aux;
        elseif (ci == nr)&(cj == nr)
            Iwa(i:end,j:end) = aux;
        end   
        cj = cj+1;        
    end
    ci = ci+1;
    cj = 1;
end
end