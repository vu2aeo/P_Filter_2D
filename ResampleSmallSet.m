%Resample algorithm for smaller particle sets

function reSampled = ResampleSmallSet(obsVal,wts)

l = size(obsVal,1);

nWts = wts/sum(wts); %normalise the weights

chkWts = cumsum(nWts); %find cumsum

ruler = (linspace(0,1,l)' * ones(1,l))';% set up a square shaped comparator

matChkWts = chkWts * ones(1,l); % get a square shaped norm wt matrix

comp = matChkWts >= ruler; % find elements that will survive

loc1 = cumsum(comp); % add up col wise

[idx b] = find(loc1==1); % get indexes of first match == 1

reSampled = obsVal(idx,:); % generated resampled data

reSampled(1,:) = reSampled(2,:); % get rid of element 1

reSampled(l,:) = reSampled(l-1,:); % get rid of elementl

end
