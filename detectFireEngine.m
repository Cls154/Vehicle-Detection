function [isFireEngineConditional, isFireEngine] = detectFireEngine(isRedConditional, width, length)
    % detectFireEngine function - Determines whether or not a vehicle is
    % a fire engine according to colour and width/length ratio
    %
    % Inputs:
    %   isRedConditional        - Boolean indicating if image is red
    %   width                   - Double for vehicle width
    %   length                  - Double for vehicle length
    %
    % Outputs:
    %   isFireEngineConditional - Boolean indicating if a fire engine is present
    %   isFireEngine            - String representing a boolean property Y/N
    
    % Width Length Ratio to be considered fire engine is 1:3
    widthRatio = 1; 
    lengthRatio = 3;
    
    % If is red and width length ratio is 1:3
    if isRedConditional && width/width == widthRatio && round(length/width) == lengthRatio
        isFireEngineConditional = true;
        isFireEngine = 'Y';

    % If NOT red and width length ratio is NOT 1:3
    else
        isFireEngineConditional = false;
        isFireEngine = 'N';
    end   
end