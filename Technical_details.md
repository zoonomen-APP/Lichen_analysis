Here's your text formatted uniformly for markdown:

```markdown
# Geolocation Data in Consortium of Lichen Herbaria Portal Data
## Correlation of County Location and decimalLatitude-decimalLongitude Values

Symbiota records (e.g. Lichen Portal records) include administrative (country, stateProvince, county, locality descriptions) and coordinate components (decimalLatitude, decimalLongitude).

For US records containing both stateProvince and county information as well as latitude and longitude coordinates, potential data errors can be identified by checking for mismatches. When stated county boundaries are exceeded by geographic coordinates, the coordinates, administrative region, or both may be incorrect.

## Methods

I used US Census TIGER/Line boundary data via the R 'tigris' package to test whether record coordinates fall within stated county boundaries. The 2024 state and county boundaries use the GCS NAD83 datum with six decimal places (though positional accuracy may be less precise).

For records with adequate data, the process:

- Checked if decimalLatitude/decimalLongitude coordinates fell within the named county boundary
- Calculated distances to the nearest relevant county boundary for mismatched records
- Identified which county actually contains the recorded coordinate pair
- Extracted and saved flagged records by herbarium and by state, ranking them by distance from stated county boundary

## TIGER/Line Boundary Data

The US Census TIGER/Line boundary data was used via the R 'tigris' package allowing digital latitude and longitude delimitation of the administrative boundaries.

The TIGER/Line data has these characteristics according to the [TIGER/Line Technical Documentation](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2024/TGRSHP2024_TechDoc_Ch3.pdf):

### 3.3.3 Datum (GCS NAD 83)

> Each shapefile contains a projection (.prj) file that contains the GIS industry standard well-known text (WKT) format to describe the coordinate system, projection, datum information for each shapefile. All Census Bureau generated TIGER/Line Shapefiles are in Global Coordinate System North American Datum of 1983 (GCS NAD83).

### 3.3.6 Coordinates

> Coordinates in the TIGER/Line Shapefiles have six decimal places, but the positional accuracy of these coordinates may not be as great as the six decimal places suggest. The spatial accuracy varies with the source materials used. The Census Bureau cannot specify the spatial accuracy of features changed or added by field staff or through local updates, features derived from the GBF/DIME Files (TIGER's predecessor in 1970 and 1980), or other map or digital sources.

## Data Precision

Data within the Portal has decimalLatitude and decimalLongitude recorded with precision as high as 16 decimal places.

| id | institutionCode | stateProvince | county | locality | decimalLatitude | decimalLongitude |
|---|---|---|---|---|---|---|
| 5657769 | hb. Schumm | Amapá |  | Mazagão, Reserva extrativista Moracá, along BR 156 | -0.0333333333333333 | 51.75 |
| 5657793 | hb. Schumm | Amapá |  | Mazagão, Reserva extrativista Moracá, along BR 156 | -0.0333333333333333 | 51.75 |
| 5657781 | hb. Schumm | Amapá |  | Mazagão, Reserva extrativista Moracá, along BR 156 | -0.0166666666666667 | 51.85 |

**Note**: At 45 degrees latitude, 0.0000000000000001 degrees of longitude spans picometers.

For United States tigris data the precision is recorded to as high as 7.86 cm.

The most current (2024) state and county boundaries were used.

## Correlation Analysis

Correlation between latitude and longitude with stated county location was determined as follows:

A process, written in R, used decimalLatitude and decimalLatitude values to output the State and county implied by the given coordinates.

This function determines if a geographic point falls within a county boundary and calculates the distance to the boundary if it's outside.

### Function Parameters

```r
calculate_distance_to_boundary <- function(lat, lon, county_geom)
```

- **`lat`**: Latitude coordinate (decimal degrees, -90 to 90)
- **`lon`**: Longitude coordinate (decimal degrees, -180 to 180)
- **`county_geom`**: County boundary geometry (sf object from tigris/Census data)

### Step-by-Step Process

#### 1. Input Validation

```r
if (is.na(lat) || is.na(lon) || lat < -90 || lat > 90 || lon < -180 || lon > 180) {
    return(list(distance_km = NA, status = "invalid_coordinates"))
}
```

**What it does**: Checks if coordinates are valid
- Rejects missing values (NA)
- Ensures latitude is between -90° and 90° (North/South poles)
- Ensures longitude is between -180° and 180° (International Date Line)
- Returns immediately if invalid

#### 2. Create Point Geometry

```r
point <- st_sfc(st_point(c(lon, lat)), crs = 4326)
```

**What it does**: Converts lat/lon numbers into a spatial geometry object
- `st_point(c(lon, lat))`: Creates a point geometry (note: longitude first, then latitude)
- `st_sfc()`: Creates a simple feature column (spatial object container)
- `crs = 4326`: Assigns WGS84 coordinate reference system (standard GPS coordinates)

#### 3. Coordinate System Transformation

```r
point_proj <- st_transform(point, crs = 5070)
county_proj <- st_transform(county_geom, crs = 5070)
```

**Why this is crucial**:
- **Problem**: WGS84 (4326) uses degrees on a curved Earth surface - distance calculations are inaccurate
- **Solution**: Transform to EPSG:5070 (North America Albers Equal Area Conic)
- **EPSG:5070 benefits**:
  - Uses meters instead of degrees
  - Minimizes distortion across continental US
  - Allows accurate distance measurements
  - Equal-area projection preserves area relationships

#### 4. Boundary Check

```r
is_within <- st_within(point_proj, county_proj, sparse = FALSE)[1,1]
```

**What it does**: Tests if the point is inside the county boundary
- `st_within()`: Spatial predicate that returns TRUE if point is completely within the polygon
- `sparse = FALSE`: Returns a dense matrix instead of sparse matrix (easier to work with)
- `[1,1]`: Extracts the boolean result from the matrix

#### 5. Distance Calculation Logic

```r
if (is_within) {
    return(list(distance_km = 0, status = "within_boundary"))
} else {
    distance_m <- as.numeric(st_distance(point_proj, county_proj))
    return(list(distance_km = distance_m / 1000, status = "outside_boundary"))
}
```

**Two scenarios**:

**A. Point is inside boundary**:
- Distance = 0 km (no violation)
- Status indicates it's within the correct county

**B. Point is outside boundary**:
- `st_distance()`: Calculates shortest distance from point to nearest edge of county
- Uses projected coordinates (meters), so distance is accurate
- Converts meters to kilometers (`/1000`)
- Status indicates boundary violation

#### 6. Error Handling

```r
tryCatch({
    # ... all the spatial operations ...
}, error = function(e) {
    return(list(distance_km = NA, status = "calculation_error"))
})
```

**Catches potential errors**:
- Malformed geometry data
- Coordinate transformation failures
- Invalid spatial operations
- Returns graceful error status instead of crashing

### Return Values

The function always returns a list with these elements:

| Return Value | distance_km | status | Meaning |
|--------------|-------------|---------|---------|
| Valid, inside boundary | 0 | "within_boundary" | Coordinates match claimed county |
| Valid, outside boundary | X.XX | "outside_boundary" | Potential data error - X.XX km from county |
| Invalid coordinates | NA | "invalid_coordinates" | Bad lat/lon values |
| Processing error | NA | "calculation_error" | Technical problem with calculation |

### Why This Approach Works

1. **Accuracy**: Uses proper map projections for precise distance measurement
2. **Robustness**: Handles edge cases and errors gracefully
3. **Efficiency**: Single function call determines both containment and distance
4. **Standards**: Uses established GIS libraries and coordinate systems
5. **Interpretability**: Clear status codes for different scenarios

### Example Use Context

In the herbarium analysis, this function identifies specimens where:
- **distance_km = 0**: Coordinates are correct ✓
- **distance_km > 0**: Possible georeferencing errors may prompt review
- **distance_km > 10**: Likely significant errors needing review
```

**Key formatting improvements made:**

1. **Consistent heading hierarchy** using `#`, `##`, `###`, `####`
2. **Proper code blocks** with language specification (```r)
3. **Uniform lists** using `-` for bullets
4. **Formatted tables** with proper alignment
5. **Consistent spacing** between sections
6. **Proper blockquotes** for citations (using `>`)
7. **Bold/italic formatting** for emphasis
8. **Clean paragraph breaks** and logical flow