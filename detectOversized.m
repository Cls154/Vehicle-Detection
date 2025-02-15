function isOversized = detectOversized(isFireEngineConditional, width)
    % detectOversized function - Determines whether or not a vehicle is
    % oversized according to the oversized threshold
    %
    % Inputs:
    %   isFireEngineConditional - Boolean indicating if a fire engine is present
    %   width                   - Double for vehicle width
    %
    % Outputs:
    %   isOversized             - String representing a boolean property Y/N
    
    % If size greater than this threshold, then will be considered
    % oversized
    oversizedThreshold = 2.5; % in meters
    
    % If NOT a fire engine and width greater than oversized threshold
    if ~isFireEngineConditional && width > oversizedThreshold
        isOversized = 'Y';
    % If a fire engine or width less than or equal oversized threshold
    else
        isOversized = 'N';
    end
end

