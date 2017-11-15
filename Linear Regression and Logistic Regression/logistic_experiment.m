training_data = csvread('clevelandtrain.csv',1);
testing_data = csvread('clevelandtest.csv',1);
[rnum,cnum] = size(training_data);
[N,~] = size(testing_data);
% w_glm = glmfit(training_data(:,1:13),training_data(:,14),'binomial','link','logit');
for i=1:rnum
    if training_data(i,14) == 0
        training_data(i,14) = -1;
    end
end
for i=1:N
    if testing_data(i,14) == 0
        testing_data(i,14) = -1;
    end
end
training_X = training_data(:,1:13);
training_y = training_data(:,14);
testing_X = testing_data(:,1:13);
testing_y = testing_data(:, 14);
eta = 1;

new_training_X = zscore(training_X);
% glmfit
% training_Ein_glm = cross_entropy_error(training_X,training_y,w_glm);
% testing_Ein_glm = cross_entropy_error(testing_X,testing_y,w_glm);
% display(training_Ein_glm);
% display(testing_Ein_glm);
% training_classification_error= find_test_error(w_glm, training_X, training_y);
% testing_classification_error = find_test_error(w_glm, testing_X, testing_y);

w_init = zeros(cnum,1);
max_its = 100000;
[w,e_in] = logistic_reg(new_training_X, training_y, w_init, max_its, eta);
display(e_in)

% training_classification_error = find_test_error(w, training_X, training_y);
% testing_classification_error = find_test_error(w, testing_X, testing_y);
% display(training_classification_error)
% display(testing_classification_error)
% E_in = cross_entropy_error(new_testing_X',testing_y,w);
% display(E_in);
