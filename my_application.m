function my_application(img1, img2)
    %
    % my_application function - Takes in 2 vehicle images and displays 
    % original image & binary image with bounding box with statistics
    %
    % Inputs:
    %   img1 - First vehicle image
    %   img2 - Second vehicle image
    %
    % Outputs:
    %   Displays text and images to console in neat format

    viewAnglePerPixel = 0.042; % in degrees
    cameraHeight = 7; % in meters
    cameraOpticalAxis = 30; % in degrees
    originPoint = {240, 320}; % resolution is 480X640 pixels
    images = {img1, img2}; % The 2 images that are inputted
    
    % Empty arrays
    distances = zeros(1, 2);
    widths = zeros(1, 2);
    lengths = zeros(1, 2);

    for i = 1:2
        % Gets different and combined colour masks of the image
        [rgbMask, redMask, greenMask, blueMask] = colourMasks(images{i}); 
        
        % Draws original image
        subplot(2, length(images), i);
        imshow(images{i});
        title('Original');
        
        % Draws the binary image
        subplot(2, length(images), length(images) + i);
        imshow(rgbMask);
        title('Binary Image');
        
        % Get the position largest bounding box (the vehicle)
        stats = regionprops(rgbMask, 'BoundingBox', 'Area');
        [~, index] = max([stats.Area]);
        vehicleBoundingBox = stats(index).BoundingBox;
        
        % Draws the bounding box on the binary image
        rectangle('Position', vehicleBoundingBox, 'EdgeColor', 'r', 'LineWidth', 1);
        
        % Determines the centre point of the bounding box (the centre of the vehicle)
        vehicleCentre = {(vehicleBoundingBox(1) + vehicleBoundingBox(3) / 2), (vehicleBoundingBox(2) + vehicleBoundingBox(4) / 2)};
        
        % Fetches the distance (m) travelled from the camera to the Y vehicle
        % centre point - (distance  - double)
        % Distances for both images added to distances array
        distance = getDistance(vehicleCentre{2}, originPoint, viewAnglePerPixel, cameraHeight, cameraOpticalAxis);
        distances(i) = distance;
        
        % Fetches the width (m) of the vehicle - (vWidth - double)
        % Widths for both images added to widths array
        vWidth = getWidth(vehicleBoundingBox, distance, originPoint, viewAnglePerPixel, cameraHeight);
        widths(i) = vWidth;
        
        % Fetches the length (m) of the vehicle - (vLength - double)
        % Lengths for both images added to lengths array
        vLength = getLength(vehicleBoundingBox, originPoint, viewAnglePerPixel, cameraHeight, cameraOpticalAxis);
        lengths(i) = vLength;
        
        % Determines if the vehicle is red - (isRed - bool)
        % Determines the main RGB colour of the image - (colour - str)
        [isRed, colour] = detectColour(rgbMask, redMask, greenMask, blueMask);


    end
    
    % Determines vehicle speed (mph) between the 2 images over a 0.1s
    % time interval - (speed - double)
    speed = getSpeed(distances(1), distances(2), 0.1);
    
    % Gets highest width and length between the 2 images 
    % Why? - Work with upper boundary
    hWidth = max(widths);
    hLength = max(lengths);
    
    % Determines if a fire engine is in the image by width length ratio
    % being 1:3 and mostly red in colour
    % (isFireEngineConditional - bool) & (isFireEngine - str)
    [isFireEngineConditional, isFireEngine] = detectFireEngine(isRed, hWidth, hLength);

    % Determines if vehicle is oversized by width of non fire engines being
    % greater than 2.5m
    % (isOversized - str)
    isOversized = detectOversized(isFireEngineConditional, hWidth);

    % Determines if vehicle is speed by speed of non fire engines being
    % greater than 30mph
    % (isSpeeding - str)
    isSpeeding = detectSpeeding(isFireEngineConditional, speed);
    
    logger( ...
        round(hWidth, 1), ... % width
        round(hLength, 1), ... % length
        hWidth/hWidth + ":" + round(hLength/hWidth), ... % width length ratio
        colour, ... % isRed
        round(speed), ... % speed
        isSpeeding, ... % isSpeeding
        isOversized, ... % isOversized
        isFireEngine ... % isFireEngine
    );
    
end

