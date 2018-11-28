pkg load communications;
clear;clc;

N = 100;
n = 1:1/N:N-1;
signal = sin(2*pi*3e3*n);