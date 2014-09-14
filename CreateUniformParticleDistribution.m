%==============================================
%Create a sample particles around a position

function [sampleXY] = CreateUniformParticleDistribution(x,y,err,noParticles)

pX = x * ones(noParticles,1);

pY = y * ones(noParticles,1);

pX = AddRandomNoise(pX,err);

pY = AddRandomNoise(pY,err);

sampleXY = [pX pY];

end
