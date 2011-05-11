%
%   this script is to model the Independent Asset Model (IAM) as
%   developed in other software
%

%% This file works on its own.
%% There is a second implementation of the IAM in this directory
%% that illustrates some usage of OO programming in MATLAB.
%% The starting point for that is iamDriver.m. The class that it uses
%% is in AssetGroup.m.

rng default

tic

%start()

niter = 100

payout = 0;

assetCount = 50;

expectedAssetPerformance = 200;

assetReliability = 0.98;

performanceValue = 0.0001;

policyDuration = 365 * 24;

%policyDuration = 4

award = zeros(niter,1);

for j = 1:niter;
    
    payout = zeros(policyDuration,1);
    
    deductible = 0.05 * assetCount * expectedAssetPerformance * performanceValue;
    assetPerformanceV = expectedAssetPerformance * binornd(1, assetReliability, [assetCount,policyDuration]);
    performance = sum(assetPerformanceV,1);
    loss = performanceValue * (expectedAssetPerformance * assetCount - performance);
    unclampedPayout = loss - deductible;
    payout(loss > deductible) = unclampedPayout(loss > deductible);
    % Here is a more straightforward way of doing the above:
    % payout = loss - deductible; payout(payout<0) = 0;
    
    award(j) = sum(payout);

end

jj = award

averageAward = mean(award)

toc;


