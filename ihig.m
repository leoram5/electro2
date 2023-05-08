function [I3] = ihig(I,f)
If = fft2(I);
[P,Q] = size(If);
D=zeros(P,Q);
Do=f;
for u=1:P
    for v=1:Q
        D(u,v)=sqrt((u-P/2)^2+(v-Q/2)^2);
    end
end
H=exp(-0.5*((D/Do).^2));
H1=fftshift(H);
HPA=1-H1;%filtro pasa altos
Bf=If.*HPA;
%Bf=If.*H1;
I3=ifft2(Bf);
I3=real(I3);
end