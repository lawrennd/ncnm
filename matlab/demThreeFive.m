% DEMTHREEFIVE Try the regular IVM on 3 vs 5.

% NCNM

% Relies on NCNM toolbox vs 0.1 and IVM toolbox vs 0.221.
%/~
importTool('ivm',0.221);
importTool('svml')
%~/

rand('seed', 1e5);
randn('seed', 1e5);

dataSetName = 'threeFive';

[y, X, yTest, XTest] = ncnmLoadData(dataSetName);

% IVM Set up
dVal = 200;
prior = 0;
display = 0;
innerIters = 400;
outerIters = 15;
kernelType = {'rbf', 'white'};

selectionCriterion = 'entropy';

% SVM Set up
options = svmlopt;
options.Kernel = 2;

probLabelled = [0.03125 0.0625 0.125 0.25 0.5 0.75 1];
for i = 1:10
  for j = 1:length(probLabelled)
    prob = probLabelled(j);
    unlabelled = find(rand(size(y))>prob);

    % Create labelled only data-sets.
    ylab = y;
    Xlab = X;
    ylab(unlabelled) = [];
    Xlab(unlabelled, :) = [];
    yunlab = y;
    % Run IVM on labelled data.
    noiseModel = 'probit';
    % Intitalise IVM
    model = ivm(Xlab, ylab, kernelType, noiseModel, selectionCriterion, ...
                min([dVal length(ylab)]));
    % Optimise the IVM
    model = ivmOptimise(model, prior, display, innerIters, outerIters);
    % Select data-points in an IVM with those kernel parameters.
    model = ivmOptimiseIVM(model, display);
    % Display the final model.
    ivmDisplay(model);
    [mu, varSigma] = ivmPosteriorMeanVar(model, XTest);
    areaIVM(i, j) = rocCurve(mu, yTest);
    fprintf('IVM %d, %d: Area under ROC curve: %2.4f\n', i, j, areaIVM(i, j));
    % Store the results.
    [kernIVM(i, j), noiseIVM(i, j), ivmInfoIVM(i, j)] = ivmDeconstruct(model);
    
    % Run SVM on labelled data.
    options.KernelParam = kernIVM(i, j).comp{1}.inverseWidth/2;
    model = svml([dataSetName num2str(i) num2str(j)], options);
    model = svmltrain(model, Xlab, ylab);
    [alpha, Xactive] = svmlread(model.fname);
    % Fix bug in svmlread which doesn't recognise size of Xactive
    missingCols = size(XTest, 2) - size(Xactive, 2);
    Xactive = [Xactive zeros(size(Xactive, 1), missingCols)];
    % Make output predictions.
    testOut = XTest*Xactive'*alpha;
    areaSVM(i, j) = rocCurve(testOut, yTest);
    fprintf('SVM %d, %d, Area under ROC curve: %2.4f\n', i, j, areaSVM(i, j));
    
    % Run NCNM IVM on data.
    noiseModel = 'ncnm';
    yunlab(unlabelled) = NaN;
    % Intitalise NCNM
    model = ivm(X, yunlab, kernelType, noiseModel, selectionCriterion, dVal);
    % Optimise the NCNM
    model = ivmOptimise(model, prior, display, innerIters, outerIters);
    % Select data-points in an NCNM with those kernel parameters.
    model = ivmOptimiseIVM(model, display);
    % Display the final model.
    ivmDisplay(model);
    [mu, varSigma] = ivmPosteriorMeanVar(model, XTest);
    areaNCNM(i, j) = rocCurve(mu, yTest);
    fprintf('NCNM %d, %d: Area under ROC curve: %2.4f\n', i, j, areaNCNM(i, j));
    % Store the results.
    [kernNCNM(i, j), noiseNCNM(i, j), ivmInfoNCNM(i, j)] = ivmDeconstruct(model);
    
    % Run Transductive SVM on data.
    yunlab(unlabelled) = 0;
    options.KernelParam = kernNCNM(i, j).comp{1}.inverseWidth/2;
    model = svml([dataSetName num2str(i) num2str(j)], options);
    model = svmltrain(model, X, yunlab);
    [alpha, Xactive] = svmlread(model.fname);
    % Fix bug in svmlread which doesn't recognise size of Xactive
    missingCols = size(XTest, 2) - size(Xactive, 2);
    Xactive = [Xactive zeros(size(Xactive, 1), missingCols)];
    % Make output predictions.
    testOut = XTest*Xactive'*alpha;
    areaTSVM(i, j) = rocCurve(testOut, yTest);
    fprintf('T-SVM %d, %d, Area under ROC curve: %2.4f\n', i, j, areaTSVM(i, j));

    capName = dataSetName;
    capName(1) = upper(capName(1));
    save(['dem' capName '.mat'], ...
         'kernIVM', 'noiseIVM', ...
         'ivmInfoIVM', 'areaIVM', ...
         'areaSVM', ...
         'kernNCNM', 'noiseNCNM', ...
         'ivmInfoNCNM', 'areaNCNM', ...
         'areaTSVM');
  end
end


