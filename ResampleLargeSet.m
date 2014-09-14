function [sampledData] = ResampleLargeSet(rawData, wts)

%disp('REsampling.....');

[numSamples numFeatures] = size(rawData);

normalisedWeight = wts/sum(wts);

cumsumNW = cumsum(normalisedWeight);

ruler = rand(numSamples,1);

oner = ones(numSamples,1);

%selectedPt = [];

sampledData = [];

for i=1:numSamples

   r = ruler(i);
   
   s = find((cumsumNW > r),1);
   
   sampledData = [sampledData; rawData(s,:)];

   %selectedPt = [selectedPt, s];

end

size(sampledData);

%sampledData = rawData(selectedPt,:);

end


 
       
