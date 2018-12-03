function bytes1 = compresion_bytes(Data,u_parameter,bits)
  string_bit1=compresion_banda(Data,u_parameter,bits);
  zeros_agregar1=8 - mod(length(string_bit1), 8);
  if(zeros_agregar1 < 8)
      string_bit1 = [string_bit1 repmat('0', 1, zeros_agregar1)];
  end
  bytestring1 = reshape(string_bit1, 8, []).';
  bytes1 = bin2dec(bytestring1);
endfunction
