% 
% IAMDRIVER
%
% iamDriver.m
% This is an implementation, in MATLAB, of the Indendent Assets Model (IAM).

% This class has no relationship to IAM.m, which is a separate standalone
% implementation of the Independent Assets Model.

%%% To execute this file, make sure the directory it contains is in your
%%% path --- using File -> Set Path... to adjust the path if necessary.

%%% Open the file in the editor --- by entering
%%% >> edit iamDriver
%%% at the MATLAB Command Window prompt.

%%% Hit the "Save and Run" button.

tic

% The outer loop in this file loops over the Monte Carlo
% configurations.

ensembleCount = 10;

% In a parallelized computation, these could be farmed out to different
% processors.

% The asset model 

assetCount = 50;

assetReliability = 0.98;

expectedAssetPerformance = 200;

%%%%%%%%%%%%%

% This number converts performance to a value, e.g., to a price in dollars.
% If expectedAssetPerformance is in watts and the value is $0.10 per
% kilowatt-hour, then the performance value is 0.0001.

performanceValue = 0.0001;

% The policy duration.

policyDuration = 365 * 24;

% The inner loop is a sum over the 8760 hours in the policy duration.

% The deductible is a percentage characterizing the threshold for payouts.

deductible = 0.05 * assetCount * expectedAssetPerformance * performanceValue;

%%%%%%%%%%%%%

% The following vector is allocated to collect
% the award for each Monto Carlo run. The award is the loss for each time
% period in the policy, summed over all time periods.
awards = zeros(ensembleCount);

% Begin the Monte Carlo loop

for ensembleIndex = 1 : ensembleCount;
    % The following variable is used to accumulate the the loss over all
    % 8760 time slices in the policy duration.
    award = 0;
    % Instantiate an instance of AssetGroup
    AG = AssetGroup(expectedAssetPerformance, assetReliability, assetCount);
    for t = 0 : policyDuration - 1;
        % Get the asset performance vector and sum it up.
        assetPerformanceV = AG.assetPerformanceV;
        performance = sum(assetPerformanceV);
        % Convert this to a dollar loss
        loss = performanceValue * (expectedAssetPerformance * assetCount - performance);
        % Compare it with the deductible
        unclampedPayout = loss - deductible;
        % payout is the payout at a particular time slice
        % it is nonzero only if unclampedPayout is > 0.
        payout = 0;
        if (unclampedPayout > 0);
            payout = unclampedPayout;
        end
        % Add the payout at this time slice to the accumulating award.
        award = award + payout;  
    end
    awards(ensembleIndex) = award;
end

%%%%%%%%%%%%%

% Present the results

averageAward = 0;
for ensembleIndex = 1 : ensembleCount;
    averageAward = averageAward + awards(ensembleIndex);
end
averageAward = averageAward / ensembleCount

%%%%%%%%%%%%%

toc


