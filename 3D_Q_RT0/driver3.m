function [T] = driver3(trials)
%
%test program that takes in number of trials
%and outputs time
Time1 = zeros(trials,1);
Time2 = zeros(trials,1);
%Time3 = zeros(trials,1);
count = 0;
nxyz = 4;
Elements = zeros(trials,1);
DegreesOfFreedom = zeros(trials,1);
Ratio1 = zeros(trials,1);
Ratio2 = zeros(trials,1);
%Ratio3 = zeros(trials,1);
while (count < trials) 
    count = count+1;
    [Times,DegreesOfFreedom(count)] = driver2(nxyz,nxyz,nxyz);
    Time1(count) = Times(1);
    Time2(count) = Times(2);
    %Time3(count) = Times(3);
    Elements(count) = nxyz * nxyz * nxyz;
    nxyz = nxyz * 2;
    if (count > 1)
        Ratio1(count) = Time1(count)/Time1(count-1);
        Ratio2(count) = Time2(count)/Time2(count-1);
        %Ratio3(count) = Time3(count)/Time3(count-1);
    end
end
T = table(Elements, DegreesOfFreedom, Time1, Time2);
return %end of function