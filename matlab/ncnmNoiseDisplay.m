function ncnmNoiseDisplay(noise)

% NCNMNOISEDISPLAY Display  parameters from null category noise model.

% NCNM

for i = 1:noise.numProcess
  fprintf('Null Cat bias on process %d: %2.4f\n', i, noise.bias(i))
end
fprintf('Null cat width: %2.4f\n', noise.width)
fprintf('Null cat Gamma -: %2.4f\n', noise.gamman)
fprintf('Null cat Gamma +: %2.4f\n', noise.gammap)
fprintf('Null cat Sigma2: %2.4f\n', noise.sigma2)
