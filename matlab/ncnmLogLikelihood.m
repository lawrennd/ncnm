function L = ncnmLogLikelihood(noise, mu, varsigma, y)

% NCNMLOGLIKELIHOOD Log-likelihood of data under null category noise model.

% NCNM

D = size(y, 2);
for i = 1:D
  mu(:, i) = mu(:, i) + noise.bias(i);
end

L = 0;
fact = sqrt(2)/2;
c = 1./sqrt(noise.sigma2 + varsigma);
epsilon = eps;
for j = 1:D
  % Do negative class first.
  index = find(y(:, j) == -1);
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.width/2;
    L = L + sum(lnCumGaussian(-mu(index, j).*c(index, j)));
    % account for observations of missingness variable.
    L = L + log((1-noise.gamman))*length(index);
  end
  
  % The null category.
  index = find(isnan(y(:, j)));
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.width/2;
    u = mu(index, j).*c(index, j);
    uprime = (mu(index, j) - noise.width).* c(index, j); 
    L = L + sum(logCumGaussSum(-u, uprime, noise.gamman, noise.gammap));
  end
  % The positive class.
  index = find(y(:, j) == 1);
  if ~isempty(index)
    mu(index, j) = mu(index, j) - noise.width/2;
    L = L + sum(lnCumGaussian(mu(index, j).*c(index, j)));
    % account for observations of missingness variable.
    L = L + log((1-noise.gammap))*length(index);
  end
end
  
