%co and CoErr must be in radians
%spd and spdErr must be in m/sec

function [newPos] = DRWithError(oldPos,co,coErr,spd,spdErr,dTSec)

l = size(oldPos,1);

co = co * ones(l,1);

d = dTSec * ones(l,1);

co = co + randn(l,1) * coErr;

spd = spd + randn(l,1) * spdErr;

d = spd .* dTSec;

newPos = [d.*sin(co),d.*cos(co)];

newPos = newPos + oldPos;

end



