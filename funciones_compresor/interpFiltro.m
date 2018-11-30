function [ynHigh, ynLow] = interpFiltro(bHigh, bLow, xn)
    D = 2;
    yn = D*upsample(xn, D);
    ynHigh = filter(bHigh, 1, yn);
    ynLow  = filter(bLow,  1, yn);
endfunction