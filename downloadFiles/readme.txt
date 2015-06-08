NCNM software
Version 0.11		Friday 21 Apr 2006 at 16:59
Copyright (c) 2006 Neil D. Lawrence


This software is released to recreate the experiments listed in the paper at http://ext.dcs.sheffield.ac.uk/~u0015/cgi-bin/bibpage.cgi?keyName=Lawrence:semisuper04.

This software has updated to work with version 0.32 of my IVM code and makes use of Anton Schwaighofer's SVM light MATLAB interface, available at http://www.cis.tugraz.at/igi/aschwaig/software.html

Version 0.11
------------

Updated release to regain compatibility with the latest versions of the IVM code.

Version 0.1
-----------

Original release, designed to operated with IVM 0.221.


MATLAB Files
------------

Matlab files associated with the toolbox are:

ncnmNoisePointPlot.m: Plot the data-points for null category noise model.
demProbit1.m: Test IVM code on a toy crescent data.
demThreeFive.m: Try the IVM & NCNM on 3 vs 5.
demThreeFiveResults.m: Plot results from the three vs five experiments.
demUnlabelled1.m: Test IVM code on a toy crescent data.
generateCrescentData.m: Generate crescent data.
lnCumGaussSum.m: The log of the weighted sum of two cumulative Gaussians.
ncnmContour.m: Special contour plot showing null category region.
ncnmLikelihood.m: Likelihood of data under null category noise model.
ncnmLoadData.m: Load a dataset.
ncnmLogLikelihood.m: Log-likelihood of data under null category noise model.
ncnmNoise3dPlot.m: Draw a 3D or contour plot for the NCNM noise model.
ncnmNoiseDisplay.m: Display  parameters from null category noise model.
ncnmNoiseExpandParam.m: Expand null category noise model's structure from param vector.
ncnmNoiseExtractParam.m: Extract parameters from null category noise model.
ncnmNoiseGradVals.m: Compute gradient with respect to inputs to noise model.
ncnmNoiseGradientParam.m: Gradient of parameters for NCNM.
ncnmNoiseNuG.m: Update nu and g parameters associated with null category noise model.
ncnmNoiseOut.m: Ouput from null category noise model.
ncnmNoiseParamInit.m: null category noise model's parameter initialisation.
ncnmNoiseSites.m: Site updates for null category model.
ncnmOptions.m: Set default options for NCNM.
ncnmTwoDPlot.m: Make a 2-D plot of the null category noise model.
