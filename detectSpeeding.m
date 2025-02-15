function isSpeeding = detectSpeeding(isFireEngineConditional, speed)
    % detectSpeeding function - Determines whether or not a vehicle is
    % speeding according to the speeding threshold
    %
    % Inputs:
    %   isFireEngineConditional - Boolean indicating if a fire engine is present
    %   speed                   - Double for vehicle speed
    %
    % Outputs:
    %   isSpeeding             - String representing a boolean property Y/N

    % If speed greater than this threshold, then will be considered speeding
    speedingThreshold = 30; % in mph
    
    % If NOT a fire engine and speed greater than speeding threshold
    if ~isFireEngineConditional && speed > speedingThreshold 
        isSpeeding = 'Y';
    
    % If a fire engine or speed less than or equal speeding threshold
    else 
        isSpeeding = 'N';
    end
end

