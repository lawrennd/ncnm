function L = ncnmLikelihood(noise, mu, varsigma, y)

% NCNMLIKELIHOOD Likelihood of data under null category noise model.

% NCNM

D = size(y, 2);
for i = 1:D
  mu(:, i) = mu(:, i) + noise.bias(i);
end


c = 1./sqrt(noise.variance + varsigma);
for j = 1:D
  % Negatively labelled data.
  index = find(y(:, j) == -1);
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.width/2;
    L(index, j) = cumGaussian(-mu(index, j).*c(index, j));
    % account for observations of missingness variable.
    L(index,j) = L(index,j)*(1-noise.gamman);
  end
  
  % Missing data.
  index = find(isnan(y(:, j));
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.width/2;
    L(index, j) = noise.gamman*cumGaussian(-mu(index, j).*c(index, j)) ...
	+ noise.gammap*cumGaussian((mu(index, j) - noise.width) .* c(index, j));
  end
  % Highest category
  index = find(y(:, j) == 1);
  if ~isempty(index)
    mu(index, j) = mu(index, j) - noise.width/2;
    L(index, j) = cumGaussian(mu(index, j).*c(index, j));
    L(index,j) = L(index,j)*(1-noise.gammap);
  end
end
