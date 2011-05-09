%
%   this script is to model the Independent Assest Model as
%   developed in other software
%

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
    
    for k = 1:policyDuration;
        
        deductible = 0.05 * assetCount * expectedAssetPerformance * performanceValue;
        
        %for k = 1:assetCount
        
        %bernoulli = binornd(1,assetReliability,[assetCount,1])
        
        %end
        
        %for k = 1:assetCount
        
        assetPerformanceV = expectedAssetPerformance * binornd(1, assetReliability,[assetCount,1]);
        
        %end
        
        %stop()
        
        performance = sum(assetPerformanceV);
        
        loss = performanceValue * (expectedAssetPerformance * assetCount - performance);
        
        unclampedPayout = loss - deductible;
        
        if loss > deductible;
            
            payout(k) = unclampedPayout;
            
        end
        
        %award =
        
    end
    
    award(j) = sum(payout);
    
end

jj = award

averageAward = mean(award)

toc;


