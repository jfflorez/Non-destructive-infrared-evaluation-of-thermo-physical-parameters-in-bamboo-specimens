function [gostCoeffs,A] = triDiag(tdg,n)

% tdg tridiagonal coefficients, 1-by-3 or n-by-3 matrix
% A is and n-by-n matrix
% gostCoeffs = [tdg(1,1) tdg(1,3)]

if size(tdg,1) == 1    
    A(1,[1 2]) = tdg([2 3]);
    idx = [1 2 3];
    for i = 2:n-1
        A(i,idx) = tdg;
        idx = idx + 1;
    end
    A(n,[n-1 n]) = tdg([1 2]);
    gostCoeffs = [tdg(1) tdg(3)];
else
    A(1,[1 2]) = tdg(1,[2 3]);
    idx = [1 2 3];
    for i = 2:n-1
        A(i,idx) = tdg(i,:);
        idx = idx + 1;
    end
    A(n,[n-1 n]) = tdg(n,[1 2]);
    gostCoeffs = [tdg(1,1) tdg(n,3)];
end




end