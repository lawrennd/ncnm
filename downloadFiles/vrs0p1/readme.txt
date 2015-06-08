ReadMe file for the NCNM toolbox version 0.1 Friday, June 4, 2004 at 13:28:21
Written by Neil D. Lawrence.$Revision: 1.1 1.0 $

This is the release of the software that was used for constructing experiments listed in the paper at http://ext.dcs.sheffield.ac.uk/~u0015/cgi-bin/bibpage.cgi?keyName=Lawrence:semisuper04.

The software relies on version 0.23 of my IVM code and makes use of Anton Schwaighofer's SVM light MATLAB interface, available at http://www.cis.tugraz.at/igi/aschwaig/software.html

demProbit1.m: Test IVM code on a toy feature selection
demThreeFive.m: Try the IVM & NCNM on 3 vs 5.
demThreeFiveResults.m: Plot results from the three vs five experiments.
demUnlabelled1.m: Test IVM code on a toy feature selection
generateCrescentData.m: Generate crescent data.
lnCumGaussSum.m: The log of the weighted sum of two cumulative Gaussians.
ncnmLikelihood.m: Likelihood of data under null category noise model.
ncnmLoadData.m: Load a dataset.
ncnmLogLikelihood.m: Log-likelihood of data under null category noise model.
ncnmNoiseDisplay.m: Display  parameters from null category noise model.
ncnmNoiseExpandParam.m: Expand null category noise model's structure from param vector.
ncnmNoiseExtractParam.m: Extract parameters from null category noise model.
ncnmNoiseGradVals.m: Gradient wrt mu and varsigma of log-likelihood for null category noise model.
ncnmNoiseGradientParam.m: Gradient of the null category noise model's parameters.
ncnmNoiseNuG.m: Update nu and g parameters associated with null category noise model.
ncnmNoiseOut.m: Ouput from null category noise model.
ncnmNoiseParamInit.m: null category noise model's parameter initialisation.
ncnmNoiseSites.m: Site updates for null category model.
ncnmTwoDPlot.m: Make a 2-D plot of the null category noise model.
