function [isRed, color] = detectColour(rgbMask, redMask, greenMask, blueMask)
    % detectColour function - Determine whether or not the image is mostly
    % red (isRed) and gets the most dominant primary colour in the image
    %
    % Inputs:
    %   rgbMask   - Logical mask for all colored pixels in the image
    %   redMask   - Logical mask for red-colored pixels
    %   greenMask - Logical mask for green-colored pixels
    %   blueMask  - Logical mask for blue-colored pixels
    %
    % Outputs:
    %   isRed     - Boolean indicating if red is the dominant color
    %   color     - String indicating the dominant color ('Red', 'Green', 'Blue')
    
    % Count the total num of coloured pixels
    totalColouredPixels = sum(rgbMask(:));
    
    % Count the num of red pixels
    totalDetectedRedPixels = sum(redMask(:));

    % Count the num of green pixels
    totalDetectedGreenPixels = sum(greenMask(:));

    % Count the num of blue pixels
    totalDetectedBluePixels = sum(blueMask(:));
    
    % Define color threshold:
    % In this case color is considered dominat if constitutes more than 
    % 85% (0.85) of the total colored pixels
    isColorThreshold = 0.85;
    
    % Determine if the dominant color is red
    if (totalDetectedRedPixels / totalColouredPixels > isColorThreshold)
        isRed = true;
        color = 'Red';
    % Determine if the dominant color is Green
    elseif (totalDetectedGreenPixels / totalColouredPixels > isColorThreshold)
        isRed = false;
        color = 'Green';
    % Determine if the dominant color is Blue
    elseif (totalDetectedBluePixels / totalColouredPixels > isColorThreshold)
        isRed = false;
        color = 'Blue';
    end
end