pkg load communications;
clear;clc;

function [b1,b2,b3,b4] = data_decompress2()
  tic;
  file_path = input("Escribe la direccion y nombre del archivo comprimido >> ","s");
  file = fopen(file_path,'r');
  ## Se recupera el encabezado
  Vmax_c1 = fread(file,1,'uint32');
  Vmax_c2 = fread(file,1,'uint32');
  Vmax_c3 = fread(file,1,'uint32');
  Vmax_c4 = fread(file,1,'uint32');
  bits_c1 = fread(file,1,'uint8');
  bits_c2 = fread(file,1,'uint8');
  bits_c3 = fread(file,1,'uint8');
  bits_c4 = fread(file,1,'uint8');
  c_size =fread(file,1,'uint64');
  ## Se recuperan los datos
  i = 1;
  while( !feof(file))
    temp = fread(file,1,'uint8');
    if(length(temp)!= 0)
      data(i) = temp;
    endif
    i++;
  endwhile
   ##Se obtienen los datos en bin
  c = dec2bin(data,8);
  for i = 1:length(c)
    c_r(1+(i-1)*8:8*i)=c(i,:);
  endfor
  ##Se ordenan datos según extensión en la muestra correspondiente
  limit_c1 = ceil(bits_c1*c_size/8)*8;
  limit_c2 = ceil(bits_c2*c_size/8)*8 + limit_c1;
  limit_c3 = ceil(bits_c3*c_size/8)*8 + limit_c2;
  for i = 1:c_size
    d_c1(i,1:bits_c1) = c_r(1+bits_c1*(i-1):bits_c1*i);
    d_c2(i,1:bits_c2) = c_r(limit_c1+1+bits_c1*(i-1):limit_c1+bits_c1*i);
    d_c3(i,1:bits_c3) = c_r(limit_c2+1+bits_c1*(i-1):limit_c2+bits_c1*i);
    d_c4(i,1:bits_c4) = c_r(limit_c3+1+bits_c1*(i-1):limit_c3+bits_c1*i);
  endfor
  ##Se quita el offset, se normaliza, se expande con mu-law y desnormaliza
  d_c1 = (bin2dec(d_c1)-(2^(bits_c1-1)-1))/(2^(bits_c1-1)-1); ##Se quita el offset y se normaliza
  exp_c1 = compand(d_c1,255,1,"mu/expander"); ##Se expande con algoritmo mu-law
  b1 = exp_c1 * Vmax_c1; ## Se desnormaliza
  ##B2
  d_c2 = (bin2dec(d_c2)-(2^(bits_c2-1)-1))/(2^(bits_c2-1)-1);
  exp_c2 = compand(d_c2,255,1,"mu/expander"); 
  b2 = exp_c2 * Vmax_c2;
  ##B3
  d_c3 = (bin2dec(d_c3)-(2^(bits_c3-1)-1))/(2^(bits_c3-1)-1);
  exp_c3 = compand(d_c3,255,1,"mu/expander"); 
  b3 = exp_c3 * Vmax_c3; 
  ##B4
  d_c4 = (bin2dec(d_c4)-(2^(bits_c4-1)-1))/(2^(bits_c4-1)-1);
  exp_c4 = compand(d_c4,255,1,"mu/expander"); 
  b4 = exp_c4 * Vmax_c4; 
  toc;
  
endfunction