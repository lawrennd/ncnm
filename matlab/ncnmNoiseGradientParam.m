function g = ncnmNoiseGradientParam(noise, mu, varsigma, y)

% NCNMNOISEGRADIENTPARAM Gradient of the null category noise model's parameters.

% NCNM

D = size(y, 2);
for i = 1:D
  mu(:, i) = mu(:, i) + noise.bias(i);
end
c = 1./sqrt(noise.sigma2 + varsigma);
gnoise.bias = zeros(1, D);
gnoise.gammap = 0;
gnoise.gamman = 0;
for j = 1:D
  % Do negative category first.
  index = find(y(:, j)==-1);
  if ~isempty(index)
    mu(index, j) = mu(index, j)+noise.width/2;
    u = mu(index, j).*c(index, j);
    gnoise.bias(j) = gnoise.bias(j) - sum(c(index, j).*gradLogCumGaussian(-u));
    gnoise.gamman = gnoise.gamman - length(index)/(1-noise.gamman);
  end

  % Do missing data.
  index = find(isnan(y(:, j)));
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.width/2;
    u = mu(index, j).*c(index, j);
    uprime = (mu(index, j) - noise.width).*c(index, j);
    denom = noise.gamman*cumGaussian(-u)+noise.gammap*cumGaussian(uprime);
    B1 = noise.gamman*ngaussian(u)./denom;
    B2 = noise.gammap*ngaussian(uprime)./denom;
    gnoise.bias(j) = gnoise.bias(j) + sum(c(index, j).*(B2-B1));
    gnoise.gammap = gnoise.gammap + sum((cumGaussian(uprime))./denom);
    gnoise.gamman = gnoise.gamman + sum((cumGaussian(-u))./denom);
  end
  
  % Highest category
  index = find(y(:, j) == 1);
  if ~isempty(index)
    mu(index, j) = mu(index, j) - noise.width/2;
    mu(index, j) = mu(index, j).*c(index, j);
    addpart = sum(c(index, j).*gradLogCumGaussian(mu(index, j)));
    gnoise.bias(j) = gnoise.bias(j) + addpart;
    % 
    gnoise.gammap = gnoise.gammap - length(index)/(1-noise.gammap);
  end
end
g = [gnoise.bias gnoise.gamman(:)'+gnoise.gammap(:)'];
%g = [gnoise.bias 0];
