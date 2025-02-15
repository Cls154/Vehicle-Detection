function distance = getDistance(yPoint, originPoint, viewAnglePerPixel, cameraHeight, cameraOpticalAxis)
    % getDistance function - Calc the distance from the camera to
    % specified Y position
    %
    % Inputs:
    %   yPoint            - Double indicating a Y position
    %   originPoint       - 1x2 Cell representing centre point (x y coord) of image
    %   viewAnglePerPixel - Double representing how the view angle changes per pixel
    %   cameraHeight      - Double representing camera height
    %   cameraOpticalAxis - Double representing the angle the camera is tilted down
    %
    % Outputs:
    %   distance          - Double indicating distance vehicle travelled
    
    % Calc num of pixels specified point is from origin point (Y axis only)
    yPixels = yPoint - originPoint{2};
    yPixels = abs(yPixels);
    
    % Multiply num of pixels by viewAngle (0.042) to get total angle
    angle = yPixels * viewAnglePerPixel;
    
    % Calc distance if Vehicle ABOVE origin point
    if yPoint < originPoint{2}
        % Calc distance using tangent trig rule -> adj = opp/tan(angle)
        angle = cameraOpticalAxis - angle;
        distance = cameraHeight / tand(angle);

    % Calc distance if Vehicle BELOW origin point
    else
        % Calc distance using tangent trig rule -> adj = opp/tan(angle)
        angle = cameraOpticalAxis + angle;
        distance = cameraHeight / tand(angle);
    end
end