% mainscript is rather short this time

% primary component count
comp_count = 40; 

[tvec tlab tstv tstl] = readSets(); 

% shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

% look at the 100 digits in the training set
imsize = 28;
fim = zeros((imsize + 2) * 10 + 2);

for clid = 1:10
  rowid = (clid - 1) * (imsize + 2) + 3;
  clsamples = find(tlab == clid)(1:10);
  for spid = 1:10
	colid = (spid - 1) * (imsize + 2) + 3;
	im = 1-reshape(tvec(clsamples(spid),:), imsize, imsize)';
	fim(rowid:rowid+imsize-1, colid:colid+imsize-1) = im;
  end
end
imshow(fim)

% check number of samples in each class
labels = unique(tlab)';
[labels; sum(tlab == labels); sum(tstl == labels)]

% compute and perform PCA transformation
[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);


% To successfully prepare ensemble you have to implement perceptron function
% I would use 10 first zeros and 10 fisrt ones 
% and only 2 first primary components
% It'll allow printing of intermediate results in perceptron function

tenzeros = tvec(tlab == 1, 1:2)(1:10, :);
tenones = tvec(tlab == 2, 1:2)(1:10, :);
pclass = tenzeros;
nclass = tenones;
plot(tenzeros(:,1), tenzeros(:,2), "r*", tenones(:,1), tenones(:,2), "bs")
%
% YOUR CODE GOES HERE - testing of the perceptron function
% [sp mpos mneg] = perceptron(allfours,allnines);
% [sp mpos mneg] = perceptron(allones,allzeros);


% Now experiment with the margin 
% It make sense to use "easy" (0 vs. 1) and "difficult" (4 vs. 9) cases.
%
%
% YOUR CODE GOES HERE - experiments with marging in the perceptron function


% training of the whole ensemble
ovo = trainOVOensemble(tvec, tlab, @perceptron);

% check your ensemble on train set
clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)

%
% YOUR CODE GOES HERE

% Train and test the OVR ensemble

% expand features
% trainExp = expandFeatures(tvec);
% testExp = expandFeatures(tstv);

% Train and test the OVO ensemble on the expanded features

% Train and test the OVR ensemble on the expanded features

% Think about improving your classifier further :)
