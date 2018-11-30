%           pseudo código
clear all; close;
%pkg load signal;

%cd
%cd Escritorio/

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

%==================================================================
%             Parametros compresion
%==================================================================
%------------------Banda1---------------------------------------
u_parameter1=255;
bit1=6;
x1=dec_1_L;
%------------------Banda2---------------------------------------
u_parameter2=255;
bit2=6;
x2=dec_2_L;
%------------------Banda3---------------------------------------
u_parameter3=255;
bit3=6;
x3=dec_3_L;
%------------------Banda4---------------------------------------
u_parameter4=255;
bit4=6;
x4=dec_4_L;

%==================================================================
%             Ejecucion de la compresion a las 4 bandas
%==================================================================
bytes1=compresion_bytes(x1,u_parameter1,bit1);
bytes2=compresion_bytes(x2,u_parameter2,bit2);
bytes3=compresion_bytes(x3,u_parameter3,bit3);
bytes4=compresion_bytes(x4,u_parameter4,bit4);
%==================================================================
%             Unificacion de los bytes en un solo array
%==================================================================
save_string=cat(2,bytes1',bytes2',bytes3',bytes4')';
%==================================================================
%             Encabezado generacion
%==================================================================
bmax1=uint32(max(abs(x1)));
bmax2=uint32(max(abs(x2)));
bmax3=uint32(max(abs(x3)));
bmax4=uint32(max(abs(x4)));
bit_banda1=uint8(bit1);
bit_banda2=uint8(bit2);
bit_banda3=uint8(bit3);
bit_banda4=uint8(bit4);
tamano=uint64(length(x1))


fid = fopen('datos.bin','w');
fwrite(fid, bmax1, 'uint32');
fwrite(fid, bmax2, 'uint32');
fwrite(fid, bmax3, 'uint32');
fwrite(fid, bmax4, 'uint32');
fwrite(fid, bit_banda1, 'uint8');
fwrite(fid, bit_banda2, 'uint8');
fwrite(fid, bit_banda3, 'uint8');
fwrite(fid, bit_banda4, 'uint8');
fwrite(fid, tamano, 'uint64');
%==================================================================
%             Escritura de los datos
%==================================================================
fwrite(fid, save_string, 'uint8');
fclose(fid);
