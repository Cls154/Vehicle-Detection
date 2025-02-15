function [rgbMask, redMask, greenMask, blueMask] = colourMasks(img)
    % colourMasks function - Gets binary masks for detecting red, green, and blue 
    % pixels in an image and a combined mask for all colored pixels.
    %
    % Inputs:
    %   img       - Image in RGB format.
    %
    % Outputs:
    %   rgbMask   - Logical mask indicating all detected colored pixels.
    %   redMask   - Logical mask for red-colored pixels.
    %   greenMask - Logical mask for green-colored pixels.
    %   blueMask  - Logical mask for blue-colored pixels.

    % Extract all primary colour components in image
    redComponent = img(:,:,1);
    greenComponent = img(:,:,2);
    blueComponent = img(:,:,3);
    
    % Minimum difference threshold between a color and other channels in 
    % order to classify it
    differenceThreshold = 25;
    
    % Create masks for primary coloured pixels
    % A pixel is considered a primary colour if tts intensity is greater 
    % than the other colour intensities by differenceThreshold units
    redMask = ...
        (redComponent - greenComponent > differenceThreshold) & ...
        (redComponent - blueComponent > differenceThreshold);

    greenMask = ...
        (greenComponent - redComponent > differenceThreshold) & ...
        (greenComponent - blueComponent > differenceThreshold);

    blueMask = ...
        (blueComponent - redComponent > differenceThreshold) & ...
        (blueComponent - greenComponent > differenceThreshold);
    
    % Combine all masks into a single mask for all detected colored pixels
    rgbMask = redMask | greenMask | blueMask;

end