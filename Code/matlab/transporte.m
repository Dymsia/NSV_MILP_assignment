

function x = transporte(s,d,c)
% function [x, cost] =transporte (s, d, c)
%
% s = offe[tamx,tamy]=size(x);r(UAV) (M*1)
% d = demand(Targets) (N*1)
% c = cost (M*n)
% x = solution ptima (M*n)
% cost = cost of transports mnimo

[x,b]=noroeste_(s,d);

iter=0;
while 1
    [u,v]=multiplicadores_(x,c,b);

   r=(c-u*ones(size(v'))-ones(size(u))*v')*(-1);
    if any(any(r<0))
        disp(' ')
        [maxv,i,j] = maspos_(r);
        if(maxv==0)
            break
        end
    else
        break
    end;
    [x,b]=ciclo_(x,i,j,b);
    iter=iter+1;
end
