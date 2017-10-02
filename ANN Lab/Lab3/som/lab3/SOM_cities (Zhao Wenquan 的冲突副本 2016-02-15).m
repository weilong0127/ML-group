% Cyclic Tour
clear all;
clc;
close all;
% Load data:cities
cities
% Use a weight matrix of size 10*2 initialized with random numbers between zero and one
% 10 nodes(cities) and 2 attributes(cites coordinate)
weight = rand(10,2);


% Use an outer loop to train the network for about 20 epochs, 
% and an inner loop which loops through the 10 cities, one at a time.
epochs = 20;
types = 10;
% Start with a neighbourhood size of 2 and then change it to 1 and finally zero.
neighbour_initial = 2;
step_size = 0.2;

for i=1:epochs
     % Make the size of the neighbourhood depend on the epoch loop variable 
     neighbour_size = round(neighbour_initial-(neighbour_initial/epochs)*i);
    for j=1:types
        % For each cities: pick out the corresponding row from the props matrix.
         p = city(j,:);
         % difference between two vectors
         difference = bsxfun(@minus, weight, p);
         % Step 1: Measure similarity
         % Calculating the euclidian distance between the input pattern and the weight vector.
         distance = sqrt(sum(difference.^2,2));% sum(X,2) means sum up each row of X
         [~,index] = min(distance); % min returns two values where the second one is the index to the minimal value
         % Step2: Update the weights
         % Define the range of neighbourhood
         % the first and the last output node are treated as next neighbours. ?
         % the lower bound of index is 1
         lower = index-neighbour_size;
         % the upper bound of index is 100
         upper = index+neighbour_size;
         % update winning weight nodes
         if lower<1
             weight(lower+types:types,:) = weight(lower+types:types,:)+step_size*bsxfun(@minus,p,weight(lower+types:types,:));
             weight(index:upper,:) = weight(index:upper,:)+step_size*bsxfun(@minus,p,weight(index:upper,:));
         elseif upper>types
             weight(1:(upper-10),:) = weight(1:(upper-10),:)+step_size*bsxfun(@minus,p,weight(1:(upper-10),:));
             weight(lower:index,:) = weight(lower:index,:)+step_size*bsxfun(@minus,p,weight(lower:index,:));
         else
             weight(lower:upper,:) = weight(lower:upper,:)+step_size*bsxfun(@minus,p,weight(lower:upper,:));
         end
    end
end

% Step 3: Presentation of the result
% If you use a 10 ? 2 matrix w to store the weights
% then the following code can be used to plot both the tour and the training points:
w = weight;
tour = [w;w(1,:)];
plot(tour(:,1),tour(:,2),'b-*',city(:,1),city(:,2),'+')
title('short route passes all cities')