function [ oobErr ] = BaggedTrees( X, Y, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%num_bag CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       num_bag : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function

% Set the num of iterations
%num_bag=50;
num_bag = numBags;

% Get label, features, and baisc parameters of the training data set
%training_data = load('zip.train');
[row_num,column_num] = size(X); %training_data);
%label = training_data(:,1);
%features = training_data(:,2:column_num);

% Main for loop for calculating out-of-bag error.
out_bag_index_round = [];
label_num_sum = zeros(row_num, 1);

for index = 1:num_bag
    % Get subsample and the out-of-bag data
    % subsample
    rand_index = randsample(row_num, row_num, true);
    labels = Y; %training_data(rand_index, 1);
    features = X; %training_data(rand_index, 2:column_num);
    sorted_labels = sort(labels);
    label_1 = sorted_labels(1, :);
    label_2 = sorted_labels(end, :);
    
    % Get the training data
    subsample_label = labels(rand_index,:);
    subsample_features = features(rand_index,:);
    
    % out-of-bag data
    out_bag_index = setdiff((1:row_num)', unique(rand_index));
    %out_bag_label = subsample_label(out_bag_index, :);
    %out_bag_features  = subsample_features(out_bag_index, :);
    
    % Build the Tree
    decision_tree = fitctree(subsample_features, subsample_label);
    
    % Get the out-of-bag data and label
    out_bag_index_round = unique([out_bag_index_round; out_bag_index]);
    length_out_bag_index = length(out_bag_index_round);
    out_bag_features = X(out_bag_index, :);
    out_bag_label = Y(out_bag_index_round, :);
    
    % Get the predicted labels
    label_predicted = predict(decision_tree, out_bag_features);
    label_predicted(label_predicted==label_1) = 1;
    label_predicted(label_predicted==label_2) = -1;
    
    % Vote for majority
    label_num_sum(out_bag_index) = label_num_sum(out_bag_index) + label_predicted;
    
    final_label = label_num_sum(out_bag_index_round);
    final_label(final_label >= 0) = label_1;
    final_label(final_label < 0) = label_2;
    
    % Count the number of different labels
    oobErr(index)=sum(abs(out_bag_label - final_label)/2)/length_out_bag_index;
    
end
    
    plot((1:num_bag), oobErr);
    xlabel('number of bag');
    ylabel('out-of-bag error');
    title('numBags VS. out-of-bag error');
end
