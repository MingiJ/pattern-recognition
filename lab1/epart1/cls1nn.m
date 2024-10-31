function [lab dist] =  cls1nn(ts, x)
% 1-NN classifier
% ts - training set; each row represents one sample
% the first column contains class label
% x - sample to be classified
% 
% lab - x's nearest neighbour in ts label
    sqdist = sumsq(ts(:,2:end) - x, 2);
    [dist idx] = min(sqdist)
    lab = ts(idx,1);
    dist = sqrt(dist);