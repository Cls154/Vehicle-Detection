function length = getLength(vehicleBoundingBox, originPoint, viewAnglePerPixel, cameraHeight, cameraOpticalAxis)
    % getLength function - Determines the length of the bounding box
    %
    % Inputs:
    %   vehicleBoundingBox - 1x4 Double indicating top left x y coord & width and length of bounding box
    %   originPoint        - 1x2 Cell representing centre point (x y coord) of image
    %   viewAnglePerPixel  - Double representing how the view angle changes per pixel
    %   cameraHeight       - Double representing camera height
    %   cameraOpticalAxis  - Double representing the angle the camera is tilted down
    %
    % Outputs:
    %   length             - Double indicating length of bounding box

    % Gets the Y coord of the top and bottom of bounding box
    upperY = vehicleBoundingBox(2);
    lowerY = vehicleBoundingBox(2) + vehicleBoundingBox(4);
    
    % Calc the distance to the top and bottom of the bounding box from the
    % camera
    frontOfVehicle = getDistance(upperY, originPoint, viewAnglePerPixel, cameraHeight, cameraOpticalAxis);
    backOfVehicle = getDistance(lowerY, originPoint, viewAnglePerPixel, cameraHeight, cameraOpticalAxis);
    
    % Subtracts the 2 distances to get the length of the bounding box (vehicle)
    length = frontOfVehicle - backOfVehicle;
end