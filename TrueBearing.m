%Returns brg in radians from P2 (vector of x and y) 
%to P1 (single x y element)

function [brg] = TrueBearing(fromPosn, ofPosn)

p2 = ofPosn;

p1 = fromPosn;

brg = atan2(p2(:,2)-p1(2),p2(:,1)-p1(1));

%adjust for quadrants

for i=1:length(brg)

  if (brg(i) < 0) 
    brg(i) = pi/2 - brg(i);
  elseif (brg(i) >= 0) 
    brg(i) = pi/2 - brg(i);
  end

end

for i=1:length(brg)
   if (brg(i) < 0) 
      brg(i) = pi*2 + brg(i);
   end
end