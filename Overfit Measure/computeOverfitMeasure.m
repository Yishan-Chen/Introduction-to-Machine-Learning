function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2
    overfit_m = 1:num_expts;
    for i = 1:num_expts
        [train_set,test_set] = generate_dataset(true_Q_f,N_train,N_test,sqrt(var));
        w_2 = glmfit(computeLegPoly(train_set(:,1)',2)',train_set(:,2),'normal','constant','off');
        w_10 = glmfit(computeLegPoly(train_set(:,1)',10)',train_set(:,2),'normal','constant','off');
        g2 = (w_2' * computeLegPoly(test_set(:,1)',2))';
        g10 = (w_10' * computeLegPoly(test_set(:,1)',10))';
        E_2_out = sum((g2 - test_set(:,2)).^2)./N_test;
        E_10_out = sum((g10 - test_set(:,2)).^2)./N_test;
        overfit_m(i) = E_10_out - E_2_out;
    end
