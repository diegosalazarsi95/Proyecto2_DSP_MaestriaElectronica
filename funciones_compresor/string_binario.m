function resultado = string_binario(Data,bits)
  string_bits=dec2bin(Data,bits);
  resultado=string_bits.'(:).';
endfunction