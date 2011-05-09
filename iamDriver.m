% 
% IAMDRIVER
%
% iamDriver.m
% This is an implementation, in MATLAB, of the Indendent Assets Model (IAM).

%%% To execute this file, make sure the directory it contains is in your
%%% path --- using File -> Set Path... to adjust the path if necessary.

%%% Open the file in the editor --- by entering
%%% >> edit iamDriver
%%% at the MATLAB Command Window prompt.

%%% Hit the "Save and Run" button.

% The outer loop in this file loops over the Monte Carlo
% configurations.

ensembleCount = 10;

% In a parallelized computation, these could be farmed out to different
% processors.

% The inner loop is a sum over the 8760 hours in the policy duration.

policyDuration = 365 * 24;

% The model 

assetCount = 50;

assetReliability = 0.98;

expectedAssetPerformance = 200;

%%%%%%%%%%%%%

% This number is a percentage characterizing the threshold for payouts.

deductible = 0.05;

% This number converts performance to a value, e.g., to a price in dollars.
% If expectedAssetPerformance is in watts and the value is $0.10 per
% kilowatt-hour, then the performance value is 0.0001.

performanceValue = 0.0001;

%%%%%%%%%%%%%

lossEnsemble = zeros(ensembleCount);

for ensembleIndex = 1 : ensembleCount;
    loss = 0;
    for hour = 0 : policyDuration - 1;
        % Maximum loss in each time slot.
        loss = loss + assetCount * expectedAssetPerformance * performanceValue;
    end
    lossEnsemble(ensembleIndex) = loss;
end

%%%%%%%%%%%%%

% Present the results

for ensembleIndex = 1 : ensembleCount;
    lossEnsemble(ensembleIndex)
end

%%%%%%%%%%%%%






