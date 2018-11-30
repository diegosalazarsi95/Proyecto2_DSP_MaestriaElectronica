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
endfunction