function logger(width, length, ratio, colour, speed, isSpeeding, isOversized, isFireEngine)
    % Logger function to output vehicle information in correct and neat
    % format
    %
    % Inputs:
    %   width        - Double indicating vehicle width
    %   length       - Double indicating vehicle length
    %   ratio        - Str representing vehicle width to length ratio
    %   colour       - Str indicating dominant primary colour
    %   speed        - Double representing vehicle speed
    %   isSpeeding   - Str indicating if vehicle speeding
    %   isOversized  - Str indicating if img is oversized
    %   isFireEngine - Str indicating if fire engine present
    %
    % Outputs:
    %   Displays text to console in neat format
    

    disp("Car Width: " + width + "meters");
    disp("Car Length: " + length + "meters");
    disp("Car Width/Length Ratio: " + ratio);
    disp("Car Colour: " + colour);
    disp("Car Speed: " + speed + "mph");
    disp("Car is Speeding: " + isSpeeding);
    disp("Car is Oversized: " + isOversized);
    disp("Car is Fire Engine: " + isFireEngine);
end