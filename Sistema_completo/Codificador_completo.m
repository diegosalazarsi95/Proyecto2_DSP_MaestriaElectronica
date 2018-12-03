clear all; close;
pkg load signal;
pkg load communications;
#!/usr/bin/env octave -q
archivo = (argv(){1});
%==================================================================
%             Parametros filtros
%==================================================================
D=2;
N = 100;
wc = 0.5;
b  = fir1(N, wc, "high");
b2 = fir1(N, wc, "low");
%==================================================================
%             primero se lee el audio
%==================================================================
[audio_in, Fs] = audioread(archivo);
%==================================================================
%     se aplica el primer diezmado
%==================================================================
[dec_L, dec_H] = filter_decimator(audio_in,D,b,b2);
%==================================================================
%     se aplica el segundo diezmado
%==================================================================
[banda1, banda2] = filter_decimator(dec_L,D,b,b2);
[banda3, banda4] = filter_decimator(dec_H,D,b,b2);

%==================================================================
%             Parametros compresion
%==================================================================
%------------------Banda1---------------------------------------
u_parameter1=255;
bit1=str2num(argv(){2});
x1=banda4;
%------------------Banda2---------------------------------------
u_parameter2=255;
bit2=str2num(argv(){3});;
x2=banda3;
%------------------Banda3---------------------------------------
u_parameter3=255;
bit3=str2num(argv(){4});;
x3=banda2;
%------------------Banda4---------------------------------------
u_parameter4=255;
bit4=str2num(argv(){5});;
x4=banda1;
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






%==================================================================
%     se aplica la interpolacion por primeravez
%==================================================================
%subanda1=interpFiltro(banda1, banda2,D,b,b2);
%subanda2=interpFiltro(banda3, banda4,D,b,b2);
%==================================================================
%     se aplica la interpolacion por segunda vez
%==================================================================
%senal=interpFiltro(subanda1, subanda2,D,b,b2);
%audiowrite('audioOut.wav', senal, Fs);
