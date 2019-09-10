
function [maxv,fil,col] = maspos(vargin)
%This funcin finds the maxvalue 
%y the posicin (line, column) of the matrix of entry
%
% Output: maxv value mximo of the entry matrix
% field line where the value exists mximo
% and column where the value exists mximo
%
%
dim = size(vargin);
if length(dim)~=2
    
end

maxv=0;
fil=0;
col=0;


% maxv value mximo of the entry matrix
maxv = max(vargin(:));
if(maxv>0)
  % find: it finds the value mximo and the posicin of the matrix of entry 
    % 1 indicates that encotrara only one value the first one that should find
    [fil,col] = find(vargin==maxv,1);
end
