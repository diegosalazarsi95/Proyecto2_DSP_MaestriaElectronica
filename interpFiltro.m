function [ynHigh, ynLow, yn] = interpFiltro(xn, bHigh, bLow)
    yn = upsample(xn, 2);
    ynHigh = filter(bHigh, 1, yn);
    ynLow  = filter(bLow,  1, yn);
endfunction