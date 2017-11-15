function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)
        
    [N,~] = size(y);
    threshold = 10^(-6);
    i = 0;
    w = w_init;
    x = [ones(N,1),X];
    while i < max_its
        i = i + 1;
        et = 0;
        for j=1:N
            et = et + (y(j) * x(j,:)')./ (1 + exp(y(j)*w'*x(j,:)'));
        end
        gt = (-1/N) * et;
        vt = -gt;
        w = w + eta * vt;
        if abs(gt) < threshold
            display(i)
            break
        end
    end
    e_in = 0;
    for j=1:N
        e_in = e_in + log(1 + exp(-y(j)*w'*x(j,:)'));
    end
    e_in = e_in / N;
end

