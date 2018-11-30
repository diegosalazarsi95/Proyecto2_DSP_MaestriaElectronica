clear all; close;
pkg load communications;
pkg load signal;

%----------------------------------------------------------%
[bAlta,bMediaAlta,bMediaBaja,bBaja] = data_decompress()

%----------------------------------------------------------%
N = 110;
wc = 0.5;

b  = fir1(N, wc, "high");
b2 = fir1(N, wc, "low");

%----------------------------------------------------------%
[xA, ] = interpFiltro(b, b2, bBaja);

[, xB] = interpFiltro(b, b2, bMediaBaja);

[xC, ] = interpFiltro(b, b2, bMediaAlta);

[, xD] = interpFiltro(b, b2, bAlta);

xE = xA + xB;

xF = xC + xD;

%----------------------------------------------------------%
[yA, ] = interpFiltro(b, b2, xE);

[, yB] = interpFiltro(b, b2, xF);

yC = yA + yB;

Fs = 22050;
audiowrite('audioOut.wav', yC, Fs);