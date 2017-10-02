% Data Clustering: Votes of MPs
clear all;
clc;
close all;
% load vote data: 
% votes.m defines a 349X31 matrix votes. 
% Each row corresponds to a specific MP and each column to a specific vote.
load_votes
% use the SOM algorithm to find a topological mapping 
% from the 31-dimensional input space to a 10*10 output grid.
% There are 10*10 nodes but and each node is 1*31
% Use a 3D matrix of size 10*10*31 initialized with random numbers between zero and one
% (10*10 output grid) and there are 31 attributes
weight = rand(10,10,31);
weight = reshape(weight,10*10,31);

% Use an outer loop to train the network for about 20 epochs, 
% and an inner loop which loops through the 349 MPs, one at a time.
epochs = 200;
MPs = 349;
step_size = 0.2;

% be used to caculate the indices of winner node in 2D map
[x,y]= meshgrid(1:10,1:10);
xpos = reshape(x, 1, 100); 
ypos = reshape(y, 1, 100);

for i=1:epochs
    for j=1:MPs
         % trained with each MPs votes as training data: votes(i,:)
         p = votes(j,:);
         % difference between two vectors
         difference = bsxfun(@minus, weight, p);
         % Step 1: Measure similarity
         % Calculating the euclidian distance between the input pattern and the weight vector.
         distance = sqrt(sum(difference.^2,2));% sum(X,2) means sum up each row of X
         [~,winner] = min(distance); % min returns two values where the second one is the index to the minimal value
         % Step2: Update the weights
         % Define the range of neighbourhood
         x_up = xpos(winner)-1;
         x_down = xpos(winner)+1;
         y_left = ypos(winner)-1;
         y_right = ypos(winner)+1;
         % Only update winner
         weight(winner,:)=weight(winner,:)+step_size*bsxfun(@minus,p,weight(winner,:));
         % Update winner 4-nearest neighbours
         % left
         if y_left>=1
             neighbour=winner-1;
             weight(neighbour,:)=weight(neighbour,:)+step_size*bsxfun(@minus,p,weight(neighbour,:));
         end
         % right
         if y_right<=10
             neighbour=winner+1;
             weight(neighbour,:)=weight(neighbour,:)+step_size*bsxfun(@minus,p,weight(neighbour,:));
         end
         % up
         if x_up>=1
             neighbour=winner-10;
             weight(neighbour,:)=weight(neighbour,:)+step_size*bsxfun(@minus,p,weight(neighbour,:));
         end
         % down
         if x_down<=10
             neighbour=winner+10;
             weight(neighbour,:)=weight(neighbour,:)+step_size*bsxfun(@minus,p,weight(neighbour,:));
         end
    end
end

% Step 3: Presentation of the result
% locate the winner output node for each MP
pos = zeros(MPs,1);
for i=1:MPs
    p = votes(i,:);
    difference = bsxfun(@minus, weight, p);
    distance = sqrt(sum(difference.^2,2));
    [~,winner] = min(distance);
    pos(i)=winner;
end
% a: each element is one output node
% (contains the index to an MP)
a = ones(1,100)*350;
a(pos) = 1:349;


% load party data: 
% mpparty.m defines a vector mpparty with the party for each MP. 
load_mpparty
figure(1)
p=[mpparty;0];
image(p(reshape(a,10,10))+1);
title('party colored map')
colorbar
% load gender data: 
load_mpsex
figure(2)
p=[mpsex;0];
image(p(reshape(a,10,10))+1);
title('gender colored map')
colorbar

% load district data: 
load_mpdistrict
figure(3)
p=[mpdistrict;0];
image(p(reshape(a,10,10))+1);
title('district colored map')
colorbar

