%==================================================================
%             Funciones compresion
%==================================================================
function y = Normalizacion(data)
    y=double(data)/max(abs(data));
end

function resultado = compresion(data, parameter)
  resultado=zeros(1,length(data));
  denominador=log(1+parameter);
  for i =1:length(data)
    if(data(i)<0)
      numerador=log(1+(parameter*abs(data(i))));
      resultado(i)=-numerador/denominador;
    else
    numerador=log(1+(parameter*abs(data(i))));
    resultado(i)=numerador/denominador;
    end
  endfor
end

function resultado = bit_select(Data, bits)
    number=2**(bits-1)-1;
    resultado=int32(Data*number)+number;
end

function resultado = string_binario(Data)
  string_bits=dec2bin(Data);
  resultado=string_bits.'(:).';
end

function string = compresion_banda(Data,u_parameter,bits)
  datos=Normalizacion(Data);
  data=compresion(datos,u_parameter);
  data_bit=bit_select(data,bits);
  string=string_binario(data_bit);
end

function bytes1 = compresion_bytes(Data,u_parameter,bits)
  string_bit1=compresion_banda(Data,u_parameter,bits);
  zeros_agregar1=8 - mod(length(string_bit1), 8);
  if(zeros_agregar1 < 8)
      string_bit1 = [string_bit1 repmat('0', 1, zeros_agregar1)];
  end
  bytestring1 = reshape(string_bit1, 8, []).';
  bytes1 = bin2dec(bytestring1);
end
