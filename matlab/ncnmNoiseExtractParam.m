function [params, names] = ncnmNoiseExtractParam(noise)

% NCNMNOISEEXTRACTPARAM Extract parameters from null category noise model.

% NCNM

params = [noise.bias noise.gamman];

if nargout > 1
  for i = 1:noise.numProcess
    names{i} = ['bias ' num2str(i)];
  end
  names{noise.numProcess+1} = ['Gamma'];
%  names{noise.numProcess+2} = ['Gamma +'];
end