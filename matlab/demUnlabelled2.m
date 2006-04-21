% DEMUNLABELLED2 Test IVM code on a toy feature selection


randn('seed', 1e6)
rand('seed', 1e6)

% Generate a toy data-set
X = [randn(100,2)-[zeros(100, 1) 6*ones(100, 1)]; randn(100,2)+[zeros(100, 1) 6*ones(100, 1)]; randn(100, 2)];
y = [ones(200, 1); -ones(100, 1)];
unlab = 1:300;
unlab([1 11 101 111 201 211]) = [];
y(unlab) = NaN;
% The probit is a classification noise model.
noiseModel = 'ncnm'; 
selectionCriterion = 'entropy';

% Use a combination of an MLP and linear ARD kernel.
kernelType = {'rbfard', 'white'};
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
  model = ivmOptimiseKernel(model, display, 100);
  if display > 1
    ncnmTwoDPlot(model, i);
  end
  % Select the active set.
  model = ivmOptimiseIVM(model, display);
  % Optimise the noise model parameters.
  model = ivmOptimiseNoise(model, display, 100);

end
if display > 1
  ncnmTwoDPlot(model, i);
end
model = ivmOptimiseIVM(model, display);
% Display the final model.
ivmDisplay(model);




