classdef AssetGroup < handle
    
% ASSETGROUP This class captures the state of a group of indenpendent
% assets. 

% This class is run by iamDriver.m

% This class has no relationship to IAM.m, which is a separate standalone
% implementation of the Independent Assets Model.
    
% Typically, there are 50 independent assets
% with expectedPerformance of each asset of 200 and an
% expected reliability of 0.98. Of course, these parameters 
% are not hard-coded. Instead they are supplied in the
% construtor.
    
% The assets randomly fail and immediately (next iteration cycle) are put
% back into service. If the asset is working, it has
% performance expectedAssetPerformance. If not, it has performance 0.
%
% Copyright (C) 2011, New Energy Risk. All Rights Reserved.
%

  properties (SetAccess = 'private')
    expectedAssetPerformance;
    assetReliability;
    assetCount;
  end
  
  properties (Dependent = true, SetAccess = private)
      assetPerformanceV;
  end

%
% Specify the asset performance methods.
%
  methods
%
%   Constructor Method
%
    function AG = AssetGroup(expectedAssetPerformance, assetReliability, assetCount)

      AG.expectedAssetPerformance = expectedAssetPerformance;
      AG.assetReliability = assetReliability;
      AG.assetCount    = assetCount;

    end  % End of constructor method.

    function assetPerformanceV = get.assetPerformanceV(AG)
        % allocate the return value
        assetCount = AG.assetCount;
        assetReliability = AG.assetReliability;
        expectedAssetPerformance = AG.expectedAssetPerformance;
        assetPerformanceV = zeros(AG.assetCount, 1);
        % Generate the noise.
        generatedNoiseV = rand(assetCount, 1);
        for n = 1:assetCount
            performance = expectedAssetPerformance;
            if generatedNoiseV(n) > assetReliability
                performance = 0;
            end
            assetPerformanceV(n) = performance;
        end
    end % End of assetPerformanceV getter
    
  end % End of methods block.

end   % End of CLASS definition statement.
