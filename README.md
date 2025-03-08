# Orbital Calculations and Ground Station Angle Determination

This script uses the **Newton-Raphson method** to solve for the **eccentric anomaly (E)** and then computes the **azimuth** and **elevation** angles for a satellite in orbit relative to a ground station.

### Parameters
- **M**: Mean anomaly (in radians)
- **e**: Eccentricity of the orbit
- **sqrta**: Square root of the semi-major axis length
- **a**: Length of the semi-major axis (calculated from the square root)
- **RE**: Radius of the Earth (in meters)
- **Omega**: Right Ascension of the ascending node
- **incl**: Orbital inclination (in radians)
- **w**: Argument of perigee
- **thetaE**: Latitude of the ground station (converted to radians)
- **phiE**: Longitude of the ground station (converted to radians)

### Newton-Raphson Method to Solve for Eccentric Anomaly (E)

1. **Define the function** `f(E) = E - e * sin(E) - M` and its derivative `f'(E) = 1 - e * cos(E)`.
2. **Initialize** an initial guess for `E`, which is set to `1`.
3. **Iteratively update** the value of `E` using the Newton-Raphson method, where:

    `E_new = E - f(E) / f'(E)`

   The loop continues until the difference between successive values of `E` is smaller than a specified tolerance (`1e-6`), or the maximum number of iterations (`100`) is reached.

4. If convergence is achieved, the value of `E` is displayed. If not, a message is printed indicating the maximum number of iterations was reached without convergence.

### Orbital Position Calculation

Once the eccentric anomaly `E` is solved for, the position in the orbital plane is calculated:

- **x0**: The x-coordinate in the orbital plane
- **y0**: The y-coordinate in the orbital plane
- **r**: The radial distance from the center of the Earth

These values are used to calculate the **declination** and **right ascension** of the satellite in space relative to the Earth’s center.

### Azimuth and Elevation Angles

Using the satellite's position in space, the following steps compute the **azimuth (Az)** and **elevation (El)** relative to the ground station:

1. **Declination (decl)**: The angle between the satellite and the Earth’s equatorial plane.
2. **PhiSE**: The difference between the ground station's longitude and the right ascension of the ascending node.
3. **EtaS**: The angle of the satellite relative to the ground station, calculated using the declination and latitude of the station.

From these angles, the **elevation (El)** and **azimuth (Az)** are calculated using the following formulas:

- **Elevation**:
  
  `El = atan((sin(eta_s) - (RE / r)) / cos(eta_s))`

- **Azimuth**:
  
  `Az = atan(sin(phiSE) / (cos(thetaE) * tan(decl) - sin(thetaE) * cos(phiSE)))`


### Final Output

- **Azimuth (Az)**: The horizontal angle between the north direction and the point directly below the satellite.
- **Elevation (El)**: The vertical angle between the satellite and the ground station.

These angles are printed as the final output.

### Example Output

```plaintext
Converged to solution: E = 0.701768
Azimuth = 55.515267
Elevation = 35.218019
