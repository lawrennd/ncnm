function noise = ncnmNoiseExpandParam(noise, params)

% NCNMNOISEEXPANDPARAM Expand null category noise model's structure from param vector.

% NCNM


noise.bias = params(1:noise.numProcess);
noise.gamman = params(noise.numProcess+1);
noise.gammap = params(noise.numProcess+2);
