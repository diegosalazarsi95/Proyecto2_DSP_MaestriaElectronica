clear all; close;
pkg load communications;
pkg load signal;

%==================================================================
%     Parametros
%==================================================================

D=2;
N = 100;
wc = 0.5;
b  = fir1(N, wc, "high");
b2 = fir1(N, wc, "low");
[audio_in, Fs] = audioread("WhosTheMonkey.wav");

%==================================================================
%     Descompresion
%==================================================================
[banda4,banda3,banda2,banda1] = data_decompress();

%==================================================================
%     se aplica la interpolacion por primeravez
%==================================================================
subanda1=interpFiltro(banda1, banda2,D,b,b2);
subanda2=interpFiltro(banda3, banda4,D,b,b2);
%==================================================================
%     se aplica la interpolacion por segunda vez
%==================================================================
senal=interpFiltro(subanda1, subanda2,D,b,b2);
audiowrite('audioOut.wav', senal, Fs);
