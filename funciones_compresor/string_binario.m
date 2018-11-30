function resultado = string_binario(Data)
  string_bits=dec2bin(Data);
  resultado=string_bits.'(:).';
endfunction