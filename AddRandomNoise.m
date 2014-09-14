% add some noise to a value

function [y] = AddRandomNoise(x,maxNoise)

m = length(x);

err = ones(m,1) .* (rand(m,1) * 2 * maxNoise) - maxNoise;

y = x + err;

end