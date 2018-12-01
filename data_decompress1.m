pkg load communications;
clear;clc;

function [b1,b2,b3,b4] = data_decompress1()
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
  ## Se obtienen los datos segun la banda
  c1 = "";
  c2 = "";
  c3 = "";
  c4 = "";
  limit_c1 = ceil(bits_c1*c_size/8);
  limit_c2 = ceil(bits_c2*c_size/8);
  limit_c3 = ceil(bits_c3*c_size/8);
  limit_c4 = ceil(bits_c4*c_size/8);
  total_data = limit_c1 + limit_c2 + limit_c3 + limit_c4;
  for i = 1:total_data
    if(i <= limit_c1)
     ##printf("Decimal: %d -- Bin: %s \n",data(i),dec2bin(data(i),8));
      c1 = [c1 dec2bin(data(i),8)];
    endif
    if(i > limit_c1 &&  i <= limit_c1+limit_c2)
      c2 = [c2 dec2bin(data(i),8)];
    endif
    if(i > limit_c1+limit_c2 &&  i <= limit_c1+limit_c2+limit_c3)
      c3 = [c3 dec2bin(data(i),8)];
    endif
    if(i > limit_c1+limit_c2+limit_c3)
      c4 = [c4 dec2bin(data(i),8)];
    endif
  endfor
  ##Se realiza la obtencion de datos, se quita offset, normaliza, aplica mu-law y desnormaliza
  d_c1 = zeros(1,c_size);
  for i = 1: c_size
    ##Se obtiene muestra segun cantidad de bits, se quita offset y se normaliza
    d_c1(i) = (bin2dec(c1(1+bits_c1*(i-1):bits_c1*i))-(2^(bits_c1-1)-1))/(2^(bits_c1-1)-1);
  endfor
  exp_c1 = compand(d_c1,255,1,"mu/expander"); ##Se expande con algoritmo mu-law
  b1 = exp_c1 * Vmax_c1; ## Se desnormaliza
  
  d_c2 = zeros(1,c_size);
  for i = 1: c_size
    d_c2(i) = (bin2dec(c2(1+bits_c2*(i-1):bits_c2*i))-(2^(bits_c2-1)-1))/(2^(bits_c2-1)-1);
  endfor
  exp_c2 = compand(d_c2,255,1,"mu/expander");
  b2 = exp_c2 * Vmax_c2;
  
  d_c3 = zeros(1,c_size);
  for i = 1: c_size
    d_c3(i) = (bin2dec(c3(1+bits_c3*(i-1):bits_c3*i))-(2^(bits_c3-1)-1))/(2^(bits_c3-1)-1);
  endfor
  exp_c3 = compand(d_c3,255,1,"mu/expander");
  b3 = exp_c3 * Vmax_c3;
  
  d_c4 = zeros(1,c_size);
  for i = 1: c_size
    d_c4(i) = (bin2dec(c4(1+bits_c4*(i-1):bits_c4*i))-(2^(bits_c4-1)-1))/(2^(bits_c4-1)-1);
  endfor
  exp_c4 = compand(d_c4,255,1,"mu/expander");
  b4 = exp_c4 * Vmax_c4;
  toc;
endfunction