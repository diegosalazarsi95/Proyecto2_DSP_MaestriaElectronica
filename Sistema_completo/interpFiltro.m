function senal = interpFiltro(xbajas,xaltas,D,b,b2)
  bajas = upsample(xbajas, D);
  altas = upsample(xaltas, D);
  bajas_filtradas = filter(b2,1,bajas);
  altas_filtradas = filter(b,1,altas);
  senal=bajas_filtradas+altas_filtradas;
endfunction
