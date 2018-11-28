clc
clear
                                                                               
%H = ( (1 - z .^ (-M)) ./ (1 - z .^ (-1))) ;
A=conv([1 -1], conv([1 -1],[1 -1])) %la convoluci´on se hace para que solo quede la parte de frecuencias bajas
B=(1/49).*(conv([1 0 0 0 -1], conv([1 0 0 0 -1],[1 0 0 0 -1])))

%
figure
freqz(B,A,2000)

function [pasa_bajas_decimada,pasa_altas_decimada] = filter_decimator(xn);

D=2;
%===============================================================================================
%                                     Filtro pasa bajas
%===============================================================================================
bl = [0.020408 0 0 0 -0.061224 0 0 0 0.061224 0 0 0 -0.020408];%Coeficientes numerador
al = [1  -3   3  -1];									                         %Coeficientes denominador

figure
freqz(bl,al,2000)
%===============================================================================================
%                                     Filtro pasa altas
%===============================================================================================
bh = [0.020408 0 0 0 -0.061224 0 0 0 0.061224 0 0 0 -0.020408];	%Coeficientes denominador
ah = [1  3  3  1];									                            %Coeficientes numerador en HP deben ser positivos


freqz(bh,ah,2000)


yn_l = filter(bl,al,xn);
yn_h = filter(bh,ah,xn);

pasa_bajas_decimada = D*downsample(yn_l,D);								%Decimación para el pasa bajas
pasa_altas_decimada = D*downsample(yn_h,D);