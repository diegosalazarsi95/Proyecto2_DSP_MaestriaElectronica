clear all; close;
% --------------------------------------------------------------
% ------------------Funciones del compresor---------------------
% --------------------------------------------------------------


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
% --------------------------------------------------------------
% ------------------Parametros compresion-----------------------
% --------------------------------------------------------------
%------------------Banda1---------------------------------------
% --------------------------------------------------------------
u_parameter1=255;
bit1=6;
x1=-1:0.01:1;
% --------------------------------------------------------------
%------------------Banda2---------------------------------------
% --------------------------------------------------------------
u_parameter2=255;
bit2=6;
x2=-1:0.01:1;
% --------------------------------------------------------------
%------------------Banda3---------------------------------------
% --------------------------------------------------------------
u_parameter3=255;
bit3=6;
x3=-1:0.01:1;
% --------------------------------------------------------------
%------------------Banda4---------------------------------------
% --------------------------------------------------------------
u_parameter4=255;
bit4=6;
x4=-1:0.01:1;
% --------------------------------------------------------------
%---------------Compresion banda 1------------------------------
% --------------------------------------------------------------
string_bit1=compresion_banda(x1,u_parameter1,bit1);
zeros_agregar1=8 - mod(length(string_bit1), 8);
if(zeros_agregar1 < 8)
    string_bit1 = [string_bit1 repmat('0', 1, zeros_agregar1)];
end
bytestring1 = reshape(string_bit1, 8, []).';
bytes1 = bin2dec(bytestring1);
% --------------------------------------------------------------
%---------------Compresion banda 2------------------------------
% --------------------------------------------------------------
string_bit2=compresion_banda(x2,u_parameter2,bit2);
zeros_agregar2=8 - mod(length(string_bit2), 8);
if(zeros_agregar1 < 8)
    string_bit2 = [string_bit2 repmat('0', 1, zeros_agregar2)];
end
bytestring2 = reshape(string_bit2, 8, []).';
bytes2 = bin2dec(bytestring2);
% --------------------------------------------------------------
%---------------Compresion banda 3------------------------------
% --------------------------------------------------------------
string_bit3=compresion_banda(x3,u_parameter3,bit3);
zeros_agregar3=8 - mod(length(string_bit3), 8);
if(zeros_agregar3 < 8)
    string_bit3 = [string_bit3 repmat('0', 1, zeros_agregar3)];
end
bytestring3 = reshape(string_bit3, 8, []).';
bytes3 = bin2dec(bytestring3);
% --------------------------------------------------------------
%---------------Compresion banda 3------------------------------s
% --------------------------------------------------------------
string_bit4=compresion_banda(x4,u_parameter4,bit4);
zeros_agregar4=8 - mod(length(string_bit4), 8);
if(zeros_agregar4 < 8)
    string_bit4 = [string_bit4 repmat('0', 1, zeros_agregar4)];
end
bytestring4 = reshape(string_bit4, 8, []).';
bytes4 = bin2dec(bytestring4);
% --------------------------------------------------------------
%-----------------------Encabezado-----------------------------
% --------------------------------------------------------------
bmax1=uint32(max(abs(x1)));
bmax2=uint32(max(abs(x2)));
bmax3=uint32(max(abs(x3)));
bmax4=uint32(max(abs(x4)));
bit_banda1=uint8(bit1);
bit_banda2=uint8(bit2);
bit_banda3=uint8(bit3);
bit_banda4=uint8(bit4);
tamano=uint64(length(x1))


fid = fopen('datos.bin','w');
fwrite(fid, bmax1, 'uint32');
fwrite(fid, bmax2, 'uint32');
fwrite(fid, bmax3, 'uint32');
fwrite(fid, bmax4, 'uint32');
fwrite(fid, bit_banda1, 'uint8');
fwrite(fid, bit_banda2, 'uint8');
fwrite(fid, bit_banda3, 'uint8');
fwrite(fid, bit_banda4, 'uint8');
fwrite(fid, tamano, 'uint64');

% --------------------------------------------------------------
%----------------unificacion de todos los string----------------
% --------------------------------------------------------------
save_string=cat(2,bytes1',bytes2',bytes3',bytes4')';
%fwrite(fid, save_string, 'uint8');
fclose(fid);











%x=dec2bin (bitset (10, 1))
%disp(typeinfo (x))
%fileID = fopen('nine.bin','w');
%  disp("hola");
%end







%allbits = cat(2, V{:,3});   % concatenate all bits into one giant binary string
%npadding = 8 - mod(length(allbits), 8); % number of bits needed to produce an even multiple of 8
%if(npadding < 8)   % pad with zeros
%    allbits = [allbits repmat('0', 1, npadding)];
%end
%bytestring = reshape(allbits, 8, []).';  % reshape into a matrix of binary strings
%bytes = bin2dec(bytestring);  % convert to integers
%fwrite(fid, bytes, 'uint8');   % be sure to write out the integers as 8-bit bytes
