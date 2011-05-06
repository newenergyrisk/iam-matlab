classdef assetPerformanceV
    
%
% ASSETPERFORMANCEV
%
%   This class captures the performance of independent assets which
%   randomly fail and immediately (next iteration cycle) are put back into
%   service. E.g., a Bernoulli distribution for each of assetCount assets
%   with reliability assetReliability. If the asset is working, it has
%   performance expectedAssetPerformance.
%
%   Copyright (C) 2011, New Energy Risk. All Rights Reserved.
%

  properties (SetAccess = 'private', GetAccess = 'public', Transient = true)
    assetPerformanceVPrivate       = [];
  end

  properties (SetAccess = 'protected', GetAccess = 'protected')
    % The following idiom wherein the orginal value of a parameter in the 
    % constructor is retained is overkill for the current implementation, but 
    % it will become useful when we move to parametric representations of 
    % the asset performance and asset reliability.
    inputExpectedAssetPerformance = [];
    inputAssetReliability = [];
    inputAssetCount = [];
  end

%
% Specify the asset performance methods.
%
  methods
%
%   Constructor Method
%
    function OBJ = assetPerformanceV(expectedAssetPerformance, assetReliability, assetCount)

      if (nargin < 3) || isempty(expectedAssetPerformance) || isempty(assetReliability) || isempty(assetCount)
          error(message('com:newenergyrisk:iam:assetPerformanceV:TooFewInputs'));
      end
%
%     Specify the (private) asset performance vector function.
%
      OBJ.assetPerformanceVPrivate = setAssetPerformanceV(expectedAssetPerformance, assetReliability, assetCount);
%
%     Store the inputs, as specified, in the corresponding "input" properties.
%
      OBJ.inputExpectedAssetPerformance = expectedAssetPerformance;
      OBJ.inputAssetReliability = assetReliability;
      OBJ.inputAssetCount    = assetCount;

    end  % End of constructor method.
    
%
%  'ExpectedAssetPerformance' Member Access Method.
%  This is additional overkill for encapsulation. It will become useful
%  in more complex models.
%
    function output = ExpectedAssetPerformance(OBJ)
        
        output = OBJ.inputExpectedAssetPerformance;
        
    end % End of 'ExpectedAssetPerformance' method.
    
%
%  'AssetReliability' Member Access Method.
%  This is additional overkill and serves toward encapsulation
%  and polymorphism. It will become useful in more complex models
%  where assets can have varied behavior.
%
    function output = AssetReliability(OBJ)
        
        output = OBJ.inputAssetReliability;
        
    end % End of 'AssetReliability' method.
    
%
%  'InputAssetCount' Member Access Method.
%  This is additional overkill for encapsulation. It will become useful
%  in more complex models.
%
    function output = AssetCount(OBJ)
        
        output = OBJ.inputAssetCount;
        
    end % End of 'InputAssetCount' method.

  end    % End of public METHODS block.

  methods (Hidden)

%
%   Display Method.
%
    function disp(OBJ)

      fprintf('   Class ASSETPERFORMANCEV: Asset Performance Specification \n');
      fprintf('   -------------------------------------------------------- \n');
      fprintf('%5s ExpectedAssetPerformance: %g\n', ' ', full(OBJ.ExpectedAssetPerformance));
      fprintf('%5s AssetReliability: %g\n', ' ', full(OBJ.AssetReliability));
      fprintf('%5s AssetCount: %g\n', ' ', full(OBJ.AssetCount));


    end    % Diffusion Display Method

  end   % End of METHODS block.

  methods (Static = true, Hidden)

%
%   Load Method.
%
    function OBJ = loadobj(OBJ)
      OBJ            = assetPerformanceV(OBJ.ExpectedAssetPerformance, OBJ.AssetReliability, OBJ.AssetCount);
    end

  end   % End of Hidden METHODS block

end   % End of CLASS definition statement.

%
% Specify the asset performance vector as a sub-function to
% enable polymorphism. This is overkill, because polymorphism
% will only become useful in more complex models where assets can have
% varied behavior. There would be an if or case statement that switches to a
% a variety of function pointers here if we had more than one behavior. At 
% present there is exactly one function pointer, @assetPerformanceV1.
%

function assetPerformanceV = setAssetPerformanceV()

  assetPerformanceV = @assetPerformanceV1;

end
%
% Provide the code for the asset performance vector functions. At present
% there is only one. All asset performance vector functions will have to
% have the same I/O syntax.
%
% Input:
%   three parameters specifying the vector to be generated
%
% Output:
%   PerformanceV - asset performance vector of length assetCount.
%
function performanceV = assetPerformanceV1(expectedAssetPerformance, assetReliability, assetCount)
% Our first performance vector function returns a vector whose components are
% simply generated randomly, and have the value expectedAssetPerformance in each
% entry with probability assetReliability --- otherwise 0.

    % Allocate performanceV.
    performanceV = zeros(assetCount);
    % Generate the noise.
    generatedNoiseV = rand(assetCount, 1);
    % Fill in the performance vector based on the generated noise.
    for n = 1:assetCount
        performance = expectedAssetPerformance;
        if generatedNoiseV(n) > assetReliability
            performance = 0;
        end
        performanceV(n) = performance;
   end
       
end
