function y = ncnmNoiseOut(noise, mu, varsigma)

% NCNMNOISEOUT Ouput from null category noise model.

% NCNM

D = size(mu, 2);
for i = 1:D
  mu(:, i) = mu(:, i) + noise.bias(i);
end

y = zeros(size(mu));
index = find(mu +noise.width/2 < 0);
y(index) = -1;
index = find(mu + noise.width/2 >= 0 & mu - noise.width/2 < 0);
y(index) = NaN;
index = find(mu - noise.width/2 >= 0);
y(index) = 1;
