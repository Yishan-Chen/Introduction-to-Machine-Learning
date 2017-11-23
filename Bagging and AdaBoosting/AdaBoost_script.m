function [ train_err, test_err ] = AdaBoost_script( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use

% Change train and test set label
y_tr(y_tr==1) = -1;
y_tr(y_tr==3) = 1;
y_te(y_te==1) = -1;
y_te(y_te==3) = 1;

% Set parameter
training_row = length(X_tr);
weight= zeros(n_trees, 1);
training_errors = zeros(n_trees, 1);
test_errors = zeros(n_trees, 1);
training_labels_array = zeros(length(y_tr), n_trees);
test_labels_array = zeros(length(y_te), n_trees);

% Initialize alpha
alpha = ones(training_row, 1) / training_row;

for iter = 1:n_trees
    
    % Build decision stumps and predict labels
    decision_stump = fitctree(X_tr, y_tr, 'Weights', alpha, 'MaxNumSplits', 1);
    predicted_labels = predict(decision_stump, X_tr);
    coeff_w = 0;
    
    % Calculate weighted error
    for weight_index = 1:training_row
        if (predicted_labels(weight_index) ~= y_tr(weight_index))
           coeff_w = coeff_w + alpha(weight_index); 
        end
    end
    weight(iter) = 0.5 * log((1 - coeff_w)/coeff_w);
    
    % Calsulate the training error
    training_labels_array(:,iter) = weight(iter) * predicted_labels;
    for i = 1:n_trees
        label_with_iter_tr = sign(sum(training_labels_array(:,1:i),2));
        training_errors(i) = sum(label_with_iter_tr ~= y_tr)/length(y_tr);
    end
    
    % Calculate the test error
    test_labels_array(:,iter) = weight(iter) * predict(decision_stump, X_te);
    for i = 1:n_trees
        label_with_iter_te = sign(sum(test_labels_array(:,1:i),2));
        test_errors(i) = sum(label_with_iter_te ~= y_te)/length(y_te);
    end
    
    % Re-calculate alpha
    for alpha_index = 1:training_row
       if (predicted_labels(alpha_index) == y_tr(alpha_index))
          alpha(alpha_index) = (alpha(alpha_index) * exp(-weight(iter)));
       else
          alpha(alpha_index) = (alpha(alpha_index) * exp(weight(iter)));
       end
       %normalization factor
       alpha(alpha_index) = alpha(alpha_index)/(2 * sqrt(coeff_w * (1 - coeff_w)));
    end        
end
train_err = training_errors;
test_err = test_errors;
end