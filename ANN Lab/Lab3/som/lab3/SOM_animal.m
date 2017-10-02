% Topological Ordering of Animal Species
clear all;
clc;
close all;
% Load data: animals
animals
% Use a weight matrix of size 100*84 initialized with random numbers between zero and one
% 100 nodes and 84 attributes
weight = rand(100,84);

% Use an outer loop to train the network for about 20 epochs, 
% and an inner loop which loops through the 32 animals, one at a time.
epochs = 20;
types = 32;
% Start with a neighbourhood of about 50 and end up close to one or zero.
neighbour_initial = 50;
step_size = 0.2;

for i=1:epochs
     % Make the size of the neighbourhood depend on the epoch loop variable 
     neighbour_size = round(neighbour_initial-(neighbour_initial/epochs)*i);
    for j=1:types
        % For each animal: pick out the corresponding row from the props matrix.
         p = props(j,:);
         % difference between two vectors
         difference = bsxfun(@minus, weight, p);
         % Step 1: Measure similarity
         % Calculating the euclidian distance between the input pattern and the weight vector.
         distance = sqrt(sum(difference.^2,2));% sum(X,2) means sum up each row of X
         [~,index] = min(distance); % min returns two values where the second one is the index to the minimal value
         % Step2: Update the weights
         % Define the range of neighbourhood
         % the lower bound of index is 1
         lower = max(1,(index-neighbour_size));
         % the upper bound of index is 100
         upper = min(100,(index+neighbour_size));
         % update winning weight nodes
         weight(lower:upper,:) = weight(lower:upper,:)+step_size*bsxfun(@minus,p,weight(lower:upper,:));
    end
end

% Step 3: Presentation of the result
% looping through all animals once more
% again calculating the index of the winning output node
% Save these indices in a 32 element vector pos.
pos = zeros(types,1);
for i=1:types
    p = props(i,:);
    difference = bsxfun(@minus, weight, p);
    distance = sqrt(sum(difference.^2,2));
    [~,index] = min(distance); 
    pos(i)=index;
end
[dummy, order] = sort(pos);
snames(order)'
%%
%compare the original one and new one
newfeature=props(order,:);
[row,col]=size(newfeature);
figure;
for i=1:row
    for j=1:col
        if newfeature(i,j)==0
            plot(j,i,'o');
        else
            plot(j,i,'*r');            
        end
        hold on;
    end
end
axis([0,85,0,33]);
axis ij;
set(gca,'xaxislocation','top');
title('Topological Ordering of Animal Species')
xlabel('features');
ylabel('species');
print('lab3/Topological Ordering of Animal Species','-dpng')
%
figure;
for i=1:row
    for j=1:col
        if props(i,j)==0
            plot(j,i,'o');
        else
            plot(j,i,'*r');            
        end
        hold on;
    end
end
axis([0,85,0,33]);
axis ij;
set(gca,'xaxislocation','top');
title('Original Ordering of Animal Species')
xlabel('features');
ylabel('species');
print('lab3/Original Ordering of Animal Species','-dpng')
