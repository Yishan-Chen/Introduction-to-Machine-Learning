function [ w iterations ] = perceptron_learn( data_in )
%perceptron_learn Run PLA on the input data
%   Inputs: data_in: Assumed to be a matrix with each row representing an
%                    (x,y) pair, with the x vector augmented with an
%                    initial 1, and the label (y) in the last column
%   Outputs: w: A weight vector (should linearly separate the data if it is
%               linearly separable)
%            iterations: The number of iterations the algorithm ran for
    [rnum, cnum] = size(data_in);
    w_test = zeros(cnum-1,1);
    sample_iterations = 0;
    total_iterations = 0;
    while sample_iterations ~= rnum
        sample_iterations = 0;
        for i = 1:rnum
            x = data_in(i,1:end-1)';
            if data_in(i,end) ~= sign(w_test' * x)
                w_test = w_test + data_in(i,end) * x;
            else
                sample_iterations = sample_iterations + 1;
            end
        end
        total_iterations = total_iterations + 1;
    end
    iterations = total_iterations;
    w = w_test;
    
    
        
        
        

