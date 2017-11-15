function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated at the corresponding x value in the input
    num_x = length(x);
    L = ones(Q+1,num_x);
    L(2,:) = x;
    for i = 3:Q+1
        j = i -1;
        L(i,:) = (2*j-1)/j .* x .* L(i-1,:) - (j-1)./j .* L(i-2,:);
    end
    z = L;
