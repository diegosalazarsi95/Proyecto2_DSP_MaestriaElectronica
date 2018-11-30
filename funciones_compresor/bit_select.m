function resultado = bit_select(Data, bits)
    number=2**(bits-1)-1;
    resultado=int32(Data*number)+number;
endfunction