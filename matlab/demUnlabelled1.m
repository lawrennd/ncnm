% DEMUNLABELLED1 Test IVM code on a toy feature selection

% NCNM

%/~
importTool('ivm', 0.221);
%~/

randn('seed', 1e6)
rand('seed', 1e6)

% Generate a toy data-set
numDataPart = 100;
[X, y] = generateCrescentData(numDataPart);
unlab = find(rand(size(y))>10/numDataPart);
y(unlab) = NaN;
% The probit is a classification noise model.
noiseModel = 'ncnm'; 
selectionCriterion = 'entropy';

% Use an rbf kernel.
kernelType = {'rbf', 'white'};
prior = 0;
display = 2;
dVal = 100;

% Initialise the model.
model = ivm(X, y, kernelType, noiseModel, selectionCriterion, dVal);
model.noise.width = 1;
prior.type = 'gamma';
prior = priorParamInit(prior);
prior.a = 1;
prior.b = 1;
prior.index = 2;
model.kern.comp{1}.priors(1) = prior;

for i = 1:15

  % Plot the data.
  if display > 1
    ncnmTwoDPlot(model, i);
  end
  % Select the active set.
  model = ivmOptimiseIVM(model, display);
  % Optimise the kernel parameters.
  model = ivmOptimiseKernel(model, 0, display, 100);
  if display > 1
    ncnmTwoDPlot(model, i);
  end
  % Select the active set.
  model = ivmOptimiseIVM(model, display);
  % Optimise the noise model parameters.
  model = ivmOptimiseNoise(model, 0, display, 100);

end
if display > 1
  ncnmTwoDPlot(model, i);
end
model = ivmOptimiseIVM(model, display);
% Display the final model.
ivmDisplay(model);
