function [g, nu] = ncnmNoiseNuG(noise, mu, varSigma, y)

% NCNMNOISENUG Update nu and g parameters associated with null category noise model.

% NCNM

[g, dlnZ_dvs] = feval([noise.type 'NoiseGradVals'], ...
		      noise, ...
		      mu, varSigma, ...
		      y);

nu = g.*g - 2*dlnZ_dvs;


for i = 1:size(mu, 2)
  index = find(nu(:, i)< eps);
  nu(index) = eps;
end
