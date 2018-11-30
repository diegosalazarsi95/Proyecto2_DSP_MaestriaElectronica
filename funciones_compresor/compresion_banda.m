function string = compresion_banda(Data,u_parameter,bits)
  datos=Normalizacion(Data);
  data=compresion(datos,u_parameter);
  data_bit=bit_select(data,bits);
  string=string_binario(data_bit,bits);
endfunction