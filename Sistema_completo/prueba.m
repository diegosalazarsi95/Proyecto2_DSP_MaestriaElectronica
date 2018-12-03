#!/usr/bin/env octave -q
n = str2num(argv(){1});
p = str2num(argv(){2});
x = 0:n;
pdf = [x; binopdf(x, n, p)];
printf("%3d  %f\n", pdf)
