function [dlnZ_dmu, dlnZ_dvs] = ncnmNoiseGradVals(noise, mu, varsigma, y)

% NCNMNOISEGRADVALS Gradient wrt mu and varsigma of log-likelihood for null category noise model.

% NCNM

D = size(y, 2);
for i = 1:D
  mu(:, i) = mu(:, i) + noise.bias(i);
end
c = 1./sqrt(noise.sigma2 + varsigma);
fact = sqrt(2)/2;
epsilon = eps;
% Missing values are left untouched at zero.
dlnZ_dmu = zeros(size(c));
dlnZ_dvs = zeros(size(c));
for j = 1:D
  % Do negative class first.
  index = find(y(:, j)==-1);
  if ~isempty(index)
    mu(index, j) = (mu(index, j)+noise.width/2).*c(index, j);
    dlnZ_dmu(index, j) = -c(index, j).*gradLogCumGaussian(-mu(index, j));
    dlnZ_dvs(index, j) = -.5*dlnZ_dmu(index, j).*c(index, j).*mu(index, j);
  end

    
  % Do missing data.
  index = find(isnan(y(:, j)));
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.width/2;
    u = mu(index, j).*c(index, j);
    uprime = (mu(index, j)-noise.width).*c(index, j);
    lndenom = lnCumGaussSum(-u, uprime, noise.gamman, noise.gammap);
    lnNumer1 = log(noise.gamman) -.5*log(2*pi) -.5*(u.*u);
    lnNumer2 = log(noise.gammap) -.5*log(2*pi) -.5*(uprime.*uprime);
    B1 = exp(lnNumer1 - lndenom);
    B2 = exp(lnNumer2 - lndenom);
    dlnZ_dmu(index, j) = c(index, j).*(B2 - B1);
    dlnZ_dvs(index, j) = -.5*c(index, j).*c(index, j).*(uprime.*B2-u.*B1);
  end
  
  % Do positive class.
  index = find(y(:, j) == 1);
  if ~isempty(index)
    mu(index, j) = mu(index, j) - noise.width/2;
    mu(index, j) = mu(index, j).*c(index, j);
    dlnZ_dmu(index, j) = c(index, j).*gradLogCumGaussian(mu(index, j));
    dlnZ_dvs(index, j) = -.5*dlnZ_dmu(index, j).*c(index, j).*mu(index, j);
    
  end
end
%/~
if any(isnan(dlnZ_dmu))
  warning('dlnZ_dmu is NaN')
end
if any(isnan(dlnZ_dvs))
  warning('dlnZ_dvs is NaN')
end
%~/