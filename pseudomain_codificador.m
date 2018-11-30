%           pseudo código
clear all; close;
pkg load signal;

cd
cd Escritorio/

%==================================================================
%             primero se lee el audio
%==================================================================
audio_in= audioread("nombre del audio");

%==================================================================
%     se aplica el primer filtrado 
%==================================================================
filter_decimator(audio_in);

%==================================================================
%     aca se toman las dos salidas de la funcion decimador
%==================================================================
dec_L = pasa_bajas_decimada		%Decimación para el pasa bajas;  
dec_H = pasa_altas_decimada   %Decimación para el pasa altas


%==================================================================
%     Se vuelve aplicar la funcion de diezmado a la salida anterior
%==================================================================
filter_decimator(dec_L);
dec_4_L = pasa_bajas_decimada		%Decimación para el pasa bajas;  
dec_3_H = pasa_altas_decimada   %Decimación para el pasa altas


filter_decimator(dec_H);
dec_2_L = pasa_bajas_decimada		%Decimación para el pasa bajas;  
dec_1_H = pasa_altas_decimada   %Decimación para el pasa altas


%==================================================================
%                 Se aplica el compresor a las salidas:
%                             dec_4_L
%                             dec_3_L
%                             dec_2_L
%                             dec_1_L
%==================================================================

funcion_compresor(dec_4_L);
funcion_compresor(dec_3_L);
funcion_compresor(dec_2_L);
funcion_compresor(dec_1_L);









