function [g, nu] = ncnmNoiseNuG(noise, mu, varSigma, y)

% NCNMNOISENUG Update nu and g parameters associated with null category noise model.

% NCNM

[g, dlnZ_dvs] = feval([noise.type 'NoiseGradVals'], ...
		      noise, ...
		      mu, varSigma, ...
		      y);

nu = g.*g - 2*dlnZ_dvs;


for i = 1:size(mu, 2)
  index = find(nu(:, i)< 0);
%   if ~isempty(index)
%     u = mu(index, i) + noise.bias(i);
%     varSig = varSigma(index, i) + noise.sigma2;
%     gp = noise.gammap*cumGaussian((u-.5*noise.width) ...
% 				  ./sqrt(varSig));
%     gn = noise.gamman*cumGaussian(-(u+.5*noise.width) ...
% 				  ./sqrt(varSig));
%     p = gn./(gn + gp);
%     effy = rand(size(p))> p;
%     effy = 2*effy-1;
%     [g(index, i), dlnZ_dvs(index, i)] = feval([noise.type 'NoiseGradVals'], ...
% 		      noise, ...
% 		      mu(index, i), varSigma(index, i), ...
% 		      effy);
%     nu(index, i) = g(index, i).*g(index, i) - 2*dlnZ_dvs(index, i);

%   end
nu(index) = eps;%g(index).*g(index);
end

nu(find(abs(nu) < eps)) = eps;
