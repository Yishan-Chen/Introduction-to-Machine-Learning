function [ num_iters bounds ] = perceptron_experiment ( N, d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bounds is the theoretical bound on the # of iterations
%              for each sample
%      (both the outputs should be num_samples long)
    w = [0; rand([d,1])];
    bound = 1:num_samples;
    num_iter = 1:num_samples;
    y = 1:N;
    difference = 1:N;
    for i = 1:num_samples
        x = [ones(N,1), 2*rand([N,d])-1]';
        R = max(norm(x));
        for j = 1:N
            y(j) = sign(w' * x(:,j));
        end
        data_set = [x', y'];
        [wt, num_iter(i)] = perceptron_learn(data_set);
        min_p = min(y .* (w' * x));
        bound(i) = R^2 * norm(w)^2 / min_p.^2;
        difference(i) = bound(i) - num_iter(i);
    end
    num_iters = num_iter;
    figure(1);
    hist(num_iter);
    title("Number of Iterations");
    
    figure(2);
    hist(log10(difference));
    title("Differences Between Bound and Nums of Iteration");
end
