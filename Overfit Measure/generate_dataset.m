function [ train_set, test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair
    a = normrnd(0,1,Q_f+1,1);
    nomralize_term = 1;
    for q=0:Q_f
        nomralize_term = nomralize_term + 1/(2*q+1);
    end
    nomralize_term = sqrt(nomralize_term);
    
    train_epsilon = randn(N_train,1);
    train_X = 2*rand(N_train,1)-1;
    train_Y = (sum(a.*computeLegPoly(train_X',Q_f))) ./ nomralize_term;
    train_F = train_Y' + sigma*train_epsilon;
    train_set = [train_X,train_F];
      
    test_epsilon = randn(N_test,1);
    test_X = 2*rand(N_test,1)-1;
    test_Y = (sum(a.*computeLegPoly(test_X',Q_f))) ./ nomralize_term;
    test_F = test_Y' + sigma*test_epsilon;
    test_set = [test_X,test_F];
    
