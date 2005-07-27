function [params, names] = ncnmNoiseExtractParam(noise)

% NCNMNOISEEXTRACTPARAM Extract parameters from null category noise model.

% NCNM

if noise.gammaSplit
  params = [noise.bias noise.gamman noise.gammap];
else
  params = [noise.bias noise.gamman];
end
  

if nargout > 1
  for i = 1:noise.numProcess
    names{i} = ['bias ' num2str(i)];
  end
  names{noise.numProcess+1} = ['Gamma -'];
  names{noise.numProcess+2} = ['Gamma +'];
end