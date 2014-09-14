function [sampledData] = Resample(rawData, normalisedWeight)

dimensions = size(rawData);

%first get the cumulative sum of the weights. 
cumsumNW = cumsum(normalisedWeight);
%Now cumsumNW holds the weights of the particles but they
%are now in the form of a sequence from 0 to 1. 

%If we imagine the particles to be placed on a "scale" from 0 to 1, the particles having larger
%weights will occupy MORE length on the scale than particles with lesser weights

%As an example.................

%Suppose there are 4 particles, having weights = 0.2, 0.55, 0.08 and 0.17
%The cumsumNW would now be [0.20 0.75 0.83 1.0]


%Suppose our scale from 0 to 1 is drawn below->
%
%|------0.1------0.2------0.3------0.4------0.5------0.6------0.7------0.8------0.9------|


%Now draw cumsumNW [0.20 0.75 0.83 1.0] on this same scale (the particles are named P1 P2 P3 and P4)

%|------0.1------0.2------0.3------0.4------0.5------0.6------0.7------0.8------0.9------|
%|<<<<P1 = 0.20>>>|<<<<<<<<<<<<<<<<<<<P2 = 0.75>>>>>>>>>>>>>>>>>>>>>|<<P3>>|<<P4 = 1.0>>>|

%As you can see from the AMOUNT OF SPACE that the particles occupy on the scale, P2 occupies
%the most space (0.2 to 0.75) followed by P1 (0 to 0.2), then P4 and finally least space is occupied by P3, 
%since P3 has the least weight

%Suppose my resampling algorithm now needs to produce 4 particles at each step
%I create a "ruler" variable using linspace(0.000001,0.99999,4)
%now ruler with contain the values [0 0.25 0.5 and 0.9999]

%run a loop through all the ruler values that compares the ruler values one at a time and re-propogates
%a given particle if it's cumsumNW is >= than the current ruler value.

%In the example above, P2 will propogate 3 times and P4 will propogate once

%So the particles having the large weights are re-propogated several times and "survive" to the next iteration.
%The particles with lesser weights will "die" away just like P1 and P3 in the example above. It may not work perfectly
%at every step, in our example P4 "survived" even though it had a less weight that P1. But by and large, particles
%with higher weights will survive and particles with lower weights will die.

%As time passes and many resampling steps are completed, the "surviving" particles will cluster around the true position

%the drawback of this looping method is that it gets very slow if the number of particles are large
%on my computer, beyond about 200 particles becomes painfully slow
%I am working on a vectorised method of resampling that should be much much faster than this looping method
%please check https://bayesianadventures.wordpress.com for updates when I get this Fast Resample algorithm working

numSamples = dimensions(1);

ruler = linspace(0.00000001,0.999999999,numSamples);

sampledData = zeros(dimensions);

count = 0;

for i=1:numSamples
   for j=1:numSamples
      count = count + 1;;
      if (cumsumNW(j) >= ruler(i)) %compare the ruler values one at a time
          sampledData(i,:) = rawData(j,:);%re-propogate a particle if it's cumsumNW is >= than the ruler value.
      break;
      end      
   end
end

%In this algorithm, the last particle is always repropogated even if it has a very low weight (since its cumsumNW 
%is always = 1). 

sampledData(numSamples) = sampledData(numSamples - 1);%So I just get rid of the last particle and replace it with the
%second last one from the resampled set

 
       
