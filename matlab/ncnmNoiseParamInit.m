function noise = ncnmNoiseParamInit(noise, y)

% NCNMNOISEPARAMINIT null category noise model's parameter initialisation.

% NCNM

% The likelihood is not log concave.
noise.logconcave = 0;

if nargin > 1
  nClass1 = sum(y==1, 1);
  nClass2 = sum(y==-1, 1);
  noise.numProcess = size(y, 2);
  noise.gamman = sum(isnan(y))/length(y);
  noise.gammap = sum(isnan(y))/length(y);
  noise.bias = 0;
else
  noise.bias = zeros(1, noise.numProcess);
  noise.gamman = 0.5;
  noise.gammap = 0.5;
end
noise.nParams = noise.numProcess;

% Constrain noise.prior to be between 0 and 1.
noise.transforms.index = [noise.numProcess+1];% noise.numProcess+2];
noise.transforms.type = 'sigmoid';

% This isn't optimised, it sets the gradient of the erf.
noise.sigma2 = eps;

% Can handle missing values?
noise.missing = 1;

noise.width = 1;
