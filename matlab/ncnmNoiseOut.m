function y = ncnmNoiseOut(noise, mu, varsigma)

% NCNMNOISEOUT Ouput from null category noise model.

% NCNM

D = size(mu, 2);
for i = 1:D
  mu(:, i) = mu(:, i) + noise.bias(i);
end
y = sign(mu);
