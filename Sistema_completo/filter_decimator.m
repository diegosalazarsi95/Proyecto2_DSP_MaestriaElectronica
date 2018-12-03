%======================================================================================
%                                   funci´on de transferencia
%                       H = ( (1 - z .^ (-M)) ./ (1 - z .^ (-1))) ;
%======================================================================================
function [pasa_bajas_decimada,pasa_altas_decimada] = filter_decimator(xn,D,b,b2);
yn_l = filter(b2,1,xn);
yn_h = filter(b,1,xn);
%==================================== esta es la salida de cada decimacion =====================
pasa_bajas_decimada = downsample(yn_l,D)*D;		%Decimación para el pasa bajas;
pasa_altas_decimada = downsample(yn_h,D)*D;   %Decimación para el pasa altas;
%bajas = upsample(pasa_bajas_decimada, D);
%altas = upsample(pasa_altas_decimada, D);
%bajas_filtradas = filter(b2,1,bajas);
%altas_filtradas = filter(b,1,altas);
%senal=bajas_filtradas+altas_filtradas;
%audiowrite('tut.wav', senal, Fs);

endfunction
