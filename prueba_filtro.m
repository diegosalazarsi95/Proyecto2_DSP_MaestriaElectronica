clc
clear
%======================================================================================   
%                                   funci´on de transferencia                                                                          
%                       H = ( (1 - z .^ (-M)) ./ (1 - z .^ (-1))) ;
%======================================================================================
function [pasa_bajas_decimada,pasa_altas_decimada] = filter_decimator(xn);

A_1=[1 -1];
B_1=[1 0 0 0 -1];

%===============================================================================================
%                                    Calculo de coeficientes
%===============================================================================================

%la convoluci´on se hace para que solo quede la parte de frecuencias bajas
A=  conv(A_1,conv(A_1, conv(A_1,conv(A_1, conv(A_1,A_1))))) 
B=(1/3300).*(conv(B_1,conv(B_1, conv(B_1,conv(B_1, conv(B_1,B_1))))))

figure
freqz(B,A,2000)

%===============================================================================================
%                                     Filtro pasa bajas
%===============================================================================================
bl =B;              %Coeficientes denominador
al = A;             %Coeficientes numerador en HP deben ser positivos

%figure
%freqz(bl,al,2000)
%===============================================================================================
%                                     Filtro pasa altas
%===============================================================================================
bh = B;	            %Coeficientes denominador
ah = abs(A);        %Coeficientes numerador en HP deben ser positivos

%figure
%freqz(bh,ah,2000)

yn_l = filter(bl,al,xn);
yn_h = filter(bh,ah,xn);

%==================================== esta es la salida de cada decimacion =====================
pasa_bajas_decimada = D*downsample(yn_l,D);		%Decimación para el pasa bajas;  
pasa_altas_decimada = D*downsample(yn_h,D);   %Decimación para el pasa altas