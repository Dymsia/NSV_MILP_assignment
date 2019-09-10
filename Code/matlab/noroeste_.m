
function [x,b]=noroeste_(s,d)
% x: envos using - regla (m*n)
% b: 1 for each variables bsicas 0 for in the bsica (m*n)
% s: you offer (m*1)
% d: you demand (n*1)
%

if (sum(s)~=sum(d)), 
  return; 
end
m=length(s);
n=length(d);
i=1;
j=1;
x=zeros(m,n);
b=zeros(m,n);
while ((i<=m) & (j<=n))
   if s(i)<d(j)
      x(i,j)=s(i);
      b(i,j)=1;
      d(j)=d(j)-s(i);
      i=i+1;
    else
      x(i,j)=d(j);
      b(i,j)=1;
      s(i)=s(i)-d(j);
      j=j+1;
    end
end
