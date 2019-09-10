

function [y,nueva_basicas]=ciclo(x,fila,col,b)
% [y, nueva_basicas] =ciclo (x, fila, col)
% x: solucin current (m*n)
% b: variables bsicas that enter (m*n)
% fila, col: ndice for the base of the element that it brings in
% y: solucin despus of the cycle of the change (m*n)
% nueva_basicas: new variables bsicas despus of the cycle of the change (m*n)
%

nueva_basicas=b;
y=x;
[m,n]=size(x);
lazo=[fila col]; % it describes the cycle of the change
x(fila,col)=Inf; % not to include (fila, col) in the bsqueda
b(fila,col)=Inf;
busca_fila=1;    % to begin to look in the same line
while (lazo(1,1)~=fila | lazo(1,2)~=col | length(lazo)==2),
  if busca_fila, % bsqueda in line
    j=1;
    while busca_fila 
       if (b(lazo(1,1),j)~=0) & (j~=lazo(1,2))  
         lazo=[lazo(1,1) j ;lazo]; % to add the ndices of the element found to the bond
         busca_fila=0;  % to begin to look in columns
       elseif j==n,    %ningn element that is interested by this line
         b(lazo(1,1),lazo(1,2))=0;
         lazo=lazo(2:length(lazo),:); %retrocede
         busca_fila=0;
       else
         j=j+1; 
       end
    end
  else  % bsqueda of the column
    i=1;
    while ~busca_fila
       if (b(i,lazo(1,2))~=0) & (i~=lazo(1,1)) 
         lazo=[i lazo(1,2) ; lazo];
         busca_fila=1;
       elseif i==m
         b(lazo(1,1),lazo(1,2))=0;
         lazo=lazo(2:length(lazo),:);
         busca_fila=1;
       else
         i=i+1;
       end
     end
  end
end
% clculo mximo - envo bond
l=length(lazo);
val_tmp=Inf;
menor_val=Inf;
for i=2:2:l
 if x(lazo(i,1),lazo(i,2))<val_tmp,
  val_tmp=x(lazo(i,1),lazo(i,2));
  menor_val=i;
 end;
end
% clculo of new transport counterfoil (matrix)
y(fila,col)=val_tmp;
for i=2:l-1
  y(lazo(i,1),lazo(i,2))=y(lazo(i,1),lazo(i,2))+(-1)^(i-1)*val_tmp;
end
nueva_basicas(fila,col)=1;
nueva_basicas(lazo(menor_val,1),lazo(menor_val,2))=0;
disp(' ');
