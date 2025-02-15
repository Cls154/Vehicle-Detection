function speed = getSpeed(distance1, distance2, timeInterval)
    % getSpeed function - Calc the speed of the vehicle between the 2
    % images at a set time interval in miles per hour (mph)
    %
    % Inputs:
    %   distance1    - Double representing distance travelled
    %   distance2    - Double representing another distance travelled
    %   timeInterval - Double representing time in seconds
    %
    % Outputs:
    %   speed        - Double indicating speed of vehicle

    conversionValue = 2.237; % to change from m/s to mph
    
    % Calcs spd in m/s via speed = distance / time
    speedMS = abs(distance1 - distance2) / timeInterval;

    % converts spd from m/s to mph
    speed = speedMS * conversionValue;
end