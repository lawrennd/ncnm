function ncnmTwoDPlot(model, iter, X, y)

% NCNMTWODPLOT Make a 2-D plot of the null category noise model.

% NCNM

if nargin < 4
  X = model.X;
  y = model.y;
end
clf
markerSize = 10;
lineWidth = 2;
title(['Iteration ' num2str(i)])
pointsNeg = plot(X(find(y(:, 1)==-1), 1), ...
		 X(find(y(:, 1)==-1), 2), ...
		 'bx', 'erasemode', 'xor', ...
		 'markersize', markerSize+2, ...
		 'linewidth', lineWidth);
hold on
pointsPos = plot(X(find(y(:, 1)==1), 1), ...
		 X(find(y(:, 1)==1), 2), 'ro', ...
		 'erasemode', 'xor', ...
		 'markersize', markerSize, ...
		 'linewidth', lineWidth);

pointUn = plot(X(:, 1), ...
	       X(:, 2), 'm.', ...
	       'erasemode', 'xor', 'markersize', 8);
set(gca, 'fontname', 'times')
set(gca, 'fontsize', 20);

if length(model.I)>0
  % It's probably learnt something.
  xlim = get(gca, 'xlim');
  ylim = get(gca, 'ylim');
  [CX, CY, CZ] = ivmMeshVals(model, xlim, ylim, 30);
  [void, clines] =contour(CX, CY, CZ, [model.noise.bias-.5 model.noise.bias+.5]);
  set(clines, 'linewidth', lineWidth, 'linestyle', '--');
  [void, clines] =contour(CX, CY, CZ, [model.noise.bias model.noise.bias]);
  set(clines, 'linewidth', lineWidth);
  
end
