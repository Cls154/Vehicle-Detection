function width = getWidth(vehicleBoundingBox, distance, originPoint, viewAnglePerPixel, cameraHeight)
    % getWidth function returns the width of the bounding box parameter
    %
    % Inputs:
    %   vehicleBoundingBox - 1x4 Double indicating top left x y coord & width and length of bounding box
    %   distance           - Double indicating distance vehicle travelled
    %   originPoint        - 1x2 Cell representing centre point (x y coord) of image
    %   viewAnglePerPixel  - Double representing how the view angle changes per pixel
    %   cameraHeight       - Double representing camera height
    %
    % Outputs:
    %   width              - Double indicating width of bounding box
    
    % Determine x coord of left and right side of bounding box
    leftSideX = vehicleBoundingBox(1);
    rightSideX = vehicleBoundingBox(1) + vehicleBoundingBox(3);
    
    % Counts num of pixels from origin point to left and right side of
    % bounding box
    toLeftPixels = abs(originPoint{1} - leftSideX);
    toRightPixels = abs(originPoint{1} - rightSideX);
    
    % Uses pythagoras theorm calc the hypotenuse between camera height and
    % distance travelled
    lineFromCamToVehicleCentre = sqrt(distance^2 + cameraHeight^2);
    
   % Calc vehicle width if vehicle is on origin line
    if leftSideX <= originPoint{1} && rightSideX >= originPoint{1}
        % Calc the width from LEFT of bounding box to origin Y point
        toLeftwidth = getPartWidth(toLeftPixels, viewAnglePerPixel, lineFromCamToVehicleCentre);
        % Calc the width from RIGHT of bounding box to origin Y point
        toRightwidth = getPartWidth(toRightPixels, viewAnglePerPixel, lineFromCamToVehicleCentre);
        % Calc total width
        width = toLeftwidth + toRightwidth;

    % Calc vehicle width if vehicle is NOT on origin line
    else 
        if toLeftPixels < toRightPixels % Vehicle is RIGHT to the origin line
            % Calc width by determining total length from origin to RIGHT
            % of vehicle and subtracting length from origin to LEFT of
            % vehicle from it
            width = getFromOverWidth(toLeftPixels, toRightPixels, viewAnglePerPixel, lineFromCamToVehicleCentre);
        else % Vehicle is LEFT to the origin line
            % Calc width by determining total length from origin to LEFT
            % of vehicle and subtracting length from origin to RIGHT of
            % vehicle from it
            width = getFromOverWidth(toRightPixels, toLeftPixels, viewAnglePerPixel, lineFromCamToVehicleCentre);
        end
    end
end

function width = getFromOverWidth(pixelCountToObj, pixelCountToAndInlcudeObj, viewAngle, adjacentSide)
    % getFromOverWidth function - Calc side length on triangle between 2 angles via tangent trig rules
    totalAngle = pixelCountToAndInlcudeObj * viewAngle;
    smallerAngle = pixelCountToObj * viewAngle;
    width = (tand(totalAngle) * adjacentSide) - (tand(smallerAngle) * adjacentSide);
end

function partWidth = getPartWidth(pixelCount, viewAngle, adjacentSide)
    % getPartWidth function - Calc side length on triangle on 1 angle via tangent trig rules
    angle = pixelCount * viewAngle;
    partWidth = tand(angle) * adjacentSide;
end