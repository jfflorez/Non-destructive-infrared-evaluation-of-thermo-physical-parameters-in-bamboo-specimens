function [i,j,k,Fijk] = min3(X)

[ni,nj,nk] = size(X);

if nk>1
    [Xij IndZ] = min(X,[],3);
    [Xi IndI] = min(Xij,[],1);
    [minX IndJ] = min(Xi);
    i = IndI(IndJ);
    j = IndJ;
    k = IndZ(i,j);
    Fijk = minX;
elseif nk==1
    [Xi IndI] = min(X,[],1);
    [minX IndJ] = min(Xi);
    i = IndI(IndJ);
    j = IndJ;
    k = 1;
    Fijk = minX;
end



end