# Vehicle-Detection


## How to Run the Program
1. Clone this repo.
2. Open in MATLAB.
4. Ensure **only 2 images** are being read at a time in `Main.m` file.
5. Run the `Main.m` file.

---

## Necessary Conditions / Assumptions
- The car is coloured.
- The diagrams provided show that the car and fire engine are predominantly one of the primary colours.
- The road is well illuminated (poor illumination compromises vehicle detection).
- The road has a neutral colour (not the same as the vehicle).
- The vehicle (foreground) can be effectively separated from the road (background) during image processing.
- The car is travelling straight (not turning) between images.
- Speed calculation assumes the vehicle maintains a straight trajectory.
- Only **one** car is captured at a time (no multiple cars in an image).

---

## System Flow

### 1. Read the Images
- Images are read using `imread`.
- Passed as parameters into the `my_application` function.

### 2. Create Colour Masks
- Used to generate a binary image by separating red, green, and blue components.
- Determines the predominant colour in each pixel.
- Masks are combined into an RGB mask.
- This effectively extracts blue cars and red fire engines.

### 3. Display Original and Binary Images
- Images are displayed using `imshow` in a subplot.

### 4. Locate the Largest Bounding Box (Vehicle)
- `regionprops` is used with `boundingbox` and `area` parameters.
- The largest area is identified as the vehicle.
- A red bounding box is drawn over the binary image.

### 5. Calculate Distance Travelled
- The bounding box is used to calculate the vehicle's center point.
- The distance from the camera is determined using trigonometric calculations:
  - `distance = camera_height / tan(optical_axis_angle)`

### 6. Calculate Vehicle Width
- Width is determined based on its position relative to the **origin line**:
  - If **right of origin** → Width = (Total length to right) - (Total length to left)
  - If **left of origin** → Width = (Total length to left) - (Total length to right)
  - If **on the origin line** → Width = (Left bounding box to origin) + (Right bounding box to origin)

### 7. Calculate Vehicle Length
- Distance to the **front and back** of the vehicle is calculated.
- Length = `|distance_front - distance_back|`

### 8. Determine Vehicle Colour
- The ratio of pixels in each colour mask is calculated.
- If the ratio of a specific colour exceeds **85%**, the vehicle is classified as that colour.

### 9. Calculate Speed Between Two Images
- Speed is calculated as:
  ```matlab
  speed (m/s) = |distance1 - distance2| / 0.1
  speed (mph) = speed (m/s) * 2.237
  ```

### 10. Determine if a Fire Engine is Present
- The width-to-length ratio is checked (1:3 ratio).
- The vehicle must also be identified as red.

### 11. Determine if the Vehicle is Oversized
- If the width exceeds **2.5 metres** and it is **not a fire engine**, the vehicle is flagged as oversized.

### 12. Determine if the Vehicle is Speeding
- If the vehicle **is not a fire engine** and exceeds **30 mph**, it is flagged as speeding.

### 13. Log Information
- All results are logged in a structured format in the console.
