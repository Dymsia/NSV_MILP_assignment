

function [u,v]=multiplicadores(x,c,b)
% [u, v] =multiplicadores (x, c, b)
% x: solucin current (m*n)
% b: 1 for every variables bsicas 0 for not bsicas (m*n)
% c: costs (m*n)
% u: lagrange multipliers for the lines (m*1)
% v: lagrange multipliers for the columns (n*1)
%
%

[m,n]=size(x);
if sum(sum(b))< m+n-1
      return; 
else
  u=Inf*ones(m,1);
  v=Inf*ones(n,1);
  u(1)=0;   % to choose an arbitrary multiplier = 0
  nr=1;
  while nr<m+n  % until all the multipliers are assigned
    for fila=1:m
      for col=1:n
        if b(fila,col)>0
          if (u(fila)~=Inf) & (v(col)==Inf)
            v(col)=c(fila,col)-u(fila);
            nr=nr+1;
          elseif (u(fila)==Inf) & (v(col)~=Inf)
            u(fila)=c(fila,col)-v(col);
            nr=nr+1;
          end
        end
      end
    end
  end
end        
