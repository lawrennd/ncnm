% DEMPROBIT1 Test IVM code on a toy feature selection

% NCNM

% Relies on IVM vs 0.23 and NCNM vs 0.1
%/~
importTool('ivm');
%~/

randn('seed', 1e6)
rand('seed', 1e6)

% Generate a toy data-set
numDataPart = 100;
[X, y] = generateCrescentData(numDataPart);
unlab = find(rand(size(y))>10/numDataPart);

% Remove unlabelled data.
y(unlab) = NaN;
origY = y;
y(unlab) = [];
origX = X;
X(unlab, :) = [];
dVal = size(X, 1);

% The probit is a classification noise model.
noiseModel = 'probit'; 
selectionCriterion = 'entropy';

% Use a combination of an MLP and linear ARD kernel.
kernelType = {'rbf', 'white'};
prior = 0;
display = 2;

% Initialise the model.
model = ivm(X, y, kernelType, noiseModel, selectionCriterion, dVal);
model.noise.bias = 0; % To make it the same as NCNM.
for i = 1:15

  % Plot the data.
  if display > 1
    ncnmTwoDPlot(model, i, origX, origY);
  end
  % Select the active set.
  model = ivmOptimiseIVM(model, display);
  % Optimise the kernel parameters.
  model = ivmOptimiseKernel(model, prior, display, 100);
  if display > 1
    ncnmTwoDPlot(model, i, origX, origY);
  end

end
model = ivmOptimiseIVM(model, display);
if display > 1
    ncnmTwoDPlot(model, i, origX, origY);

end
model = ivmOptimiseIVM(model, display);
% Display the final model.
ivmDisplay(model);
