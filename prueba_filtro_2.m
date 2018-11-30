clear all; close;
pkg load signal;

N = 110;
wc = 0.5;

b  = fir1(N, wc, "high");
b2 = fir1(N, wc, "low");

[h1,w1]=freqz(b,1);
[hl,wl]=freqz(b2,1);

%figure
%plot(wl/pi, 20*log10(abs(hl)), w1/pi, 20*log10(abs(h1)))
%ylim([-100 10]);

Fs  = 1000;
Fs2 = 2000;

t  = linspace(0, 1, Fs);
t2 = linspace(0, 1, Fs2);

f1 = 100;
f2 = 700;
f3 = 850;

x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);
x3 = sin(2*pi*f3*t);
x = x1 + x2 + x3;

[y1, y2, y3] = interpFiltro(x, b, b2);

w2 = linspace(-pi, pi, 2*Fs);

Y1 = fftshift(fft(y1));
Y2 = fftshift(fft(y2));
Y3 = fftshift(fft(y3));

figure;
plot(w2(Fs2/2:end), 20*log(abs(Y1(Fs2/2:end))), w2(Fs2/2:end), 20*log(abs(Y2(Fs2/2:end))));
xlim([0 pi]);
