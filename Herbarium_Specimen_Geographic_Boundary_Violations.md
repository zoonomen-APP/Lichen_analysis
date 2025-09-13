# Herbarium Specimen Geographic Boundary Validation

## Overview

This contains links to the results of an analysis intended to identify herbarium specimen records with Lat./Long. coordinates falling outside the boundaries of their reported collection counties. These "out-of-bounds" violation cases may be flagged due to data entry errors, coordinate conversion mistakes,  incorrect locality assignments or combinations of these. In many instances data review and possible editing may be appropriate. Very small apparent violations may be unimportant.

## Methodology

### Data Processing Pipeline

1. **Data Sources**: United States herbarium specimen records from the Consortium of Lichen Herbaria portal database. 
2. **Geographic Validation**: Stated specimen record locations are validated against official U.S. county boundaries (Census Bureau, 2020)
3. **Coordinate System**: All distance from boundary calculations are performed using EPSG:5070 (Albers Equal Area Conic) projection for accurate distance measurements
4. **Boundary Matching**: County names are standardized and matched using conservative fuzzy matching algorithms

### Validation Process

#### 1. Data Filtering
- Records limited to United States specimens based on matching the 'country' value to a wide range of variant renderings of the name.
- Only records with both latitude/longitude coordinates
- Excludes records missing state or county information
- Filters out multi-state/county entries (e.g., "CA/NV")

#### 2. Geographic Analysis
- Specimen record values of 'decimalLatitude' 'decimalLongitude' are tested for containment within reported county boundaries
- Distance calculated from coordinates to nearest county boundary edge
- Only violations (distance > 0 km) are reported

#### 3. Quality Assurance
- County name matching includes handling of common variants:
  - Standardizes "County", "Co.", "Parish", "Borough" suffixes
  - Handles abbreviations: "St." → "Saint", "Mt." → "Mount"
  - Fuzzy matching for minor spelling variations
- Coordinate validation (lat: -90 to 90, lon: -180 to 180)
- Cross-reference with reverse geocoding for "implied location"

### Output Files

Each herbarium directory contains:
- **State-specific violation files**: `{HERBARIUM}_{STATE}_violations_{timestamp}.txt`
- **Summary report**: `{HERBARIUM}_summary_{timestamp}.txt`

### Output Files

Each herbarium directory contains:
- **State-specific violation files**: `{HERBARIUM}_{STATE}_violations_{timestamp}.txt`
- **Summary report**: `{HERBARIUM}_summary_{timestamp}.txt`

#### Violation File Variables

The state-specific violation files are tab-separated text files containing the following variables for each out-of-bounds specimen record:

| Variable | Description |
|----------|-------------|
| `occurrenceID` | Unique identifier for the specimen record in the database |
| `institutionCode` | Herbarium abbreviation (e.g., OSC, DUKE, NY) |
| `recordedBy` | Collector name(s) as recorded in the original specimen data |
| `stateProvince` | State or province name where the specimen was reportedly collected |
| `county` | County name as recorded in the original specimen data |
| `distance_km` | Distance in kilometers from the reported coordinates to the nearest boundary of the stated county |
| `status` | Processing status indicating the type of boundary violation detected:<br/>• `outside_boundary_[confidence]` - coordinates fall outside stated county<br/>• `county_not_matched_[reason]` - county name could not be matched to official boundaries |
| `catalogNumber` | Specimen catalog number or collection identifier |
| `coordinates` | Decimal latitude and longitude in the format "lat,lon" |
| `implied_location` | Geographic location determined by reverse geocoding the coordinates using official county boundaries |
| `locality` | Locality description as recorded in the original specimen data |
| `record_link` | Direct URL link to view the specimen record in the online portal. Links are clickable when files are viewed as text in terminal environments (gitbash, etc.) or opened in Google Sheets, allowing immediate browser access to specimen records. Note: URL links will not be clickable if files are opened in Microsoft Excel. |

#### County Matching Confidence Levels

The `status` field includes confidence indicators for county boundary matching:

- **`exact`** - Perfect match between recorded county name and official county name
- **`standardized_exact`** - Match after standardizing abbreviations and suffixes (e.g., "Co." → "County")  
- **`partial_match`** - Recorded name partially matches an official county name
- **`similarity_[score]`** - Fuzzy string matching with similarity score (0.6+ threshold)
- **`first_word_match`** - Match based on first word of multi-word county names
- **`no_match`** - County name could not be matched to any official county in the stated province/state

#### Summary File Contents

Summary files contain statistical analysis including:
- Record counts at each filtering stage (country, coordinates, state, county)
- Total boundary violations detected and violation rate
- Distance statistics (min, max, median, quartiles) for violations
- Data quality assessment and recommendations for correction priority

## Herbarium Collections Analyzed

*Click on herbarium codes to view detailed results*

### A-C
- [ALA](./ALA/) - University of Alaska Museum of the North Herbarium
- [APSC](./APSC/) - Austin Peay State University
- [ASU](./ASU/) - Arizona State University
- [AUA](./AUA/) - University of Alabama
- [BALT](./BALT/) - Baltimore Museum
- [BRIT](./BRIT/) - Botanical Research Institute of Texas
- [BRY](./BRY/) - Brigham Young University
- [BUT](./BUT/) - Butler University
- [CAS](./CAS/) - California Academy of Sciences
- [CHRB](./CHRB/) - California State University, Chico
- [CHSC](./CHSC/) - Charleston Southern University
- [CINC](./CINC/) - University of Cincinnati
- [CLEMS](./CLEMS/) - Clemson University
- [CMN](./CMN/) - Colorado State University
- [COLO](./COLO/) - University of Colorado
- [CSCN](./CSCN/) - University of Nevada, Carson City
- [CSU](./CSU/) - Colorado State University
- [CUP](./CUP/) - Purdue University

### D-G
- [DAV](./DAV/) - University of California, Davis
- [DUKE](./DUKE/) - Duke University
- [EVE](./EVE/) - Evergreen State College
- [EWU](./EWU/) - Eastern Washington University
- [F](./F/) - Field Museum of Natural History
- [FH](./FH/) - Harvard University Farlow Herbarium
- [FLAS](./FLAS/) - University of Florida
- [FTG](./FTG/) - Fairchild Tropical Botanic Garden
- [FTU](./FTU/) - Florida International University
- [GAM](./GAM/) - University of Georgia
- [GEO](./GEO/) - Georgetown University
- [GMUF](./GMUF/) - George Mason University

### H-L
- [HPSU](./HPSU/) - High Point University
- [HSC](./HSC/) - Humboldt State University
- [Harvard_University](./Harvard_University/) - Harvard University
- [ID](./ID/) - University of Idaho
- [IDS](./IDS/) - Idaho State University
- [ILL](./ILL/) - University of Illinois
- [ILLS](./ILLS/) - Illinois State University
- [IND](./IND/) - Indiana University
- [ISC](./ISC/) - Iowa State University
- [KANU](./KANU/) - University of Kansas
- [KE](./KE/) - Kenyon College
- [KIRI](./KIRI/) - Kirtland Community College
- [LSU](./LSU/) - Louisiana State University

### M-O
- [MAINE](./MAINE/) - University of Maine
- [MCTC](./MCTC/) - Macomb Community College
- [MDKY](./MDKY/) - University of Kentucky
- [MICH](./MICH/) - University of Michigan
- [MIL](./MIL/) - University of Wisconsin, Milwaukee
- [MIN](./MIN/) - University of Minnesota
- [MONT](./MONT/) - University of Montana
- [MONTU](./MONTU/) - Montana State University
- [MOR](./MOR/) - Missouri Botanical Garden
- [MSC](./MSC/) - Mississippi State University
- [MU](./MU/) - University of Missouri
- [NBM](./NBM/) - New Brunswick Museum
- [NCU](./NCU/) - University of North Carolina
- [NEB](./NEB/) - University of Nebraska
- [NHA](./NHA/) - New Hampshire
- [NY](./NY/) - New York Botanical Garden
- [OBI](./OBI/) - Oberlin College
- [OMA](./OMA/) - University of Nebraska, Omaha
- [OS](./OS/) - Ohio State University
- [OSC](./OSC/) - Oregon State University

### P-S
- [PH](./PH/) - Academy of Natural Sciences of Philadelphia
- [RM](./RM/) - Rocky Mountain Herbarium
- [SBBG](./SBBG/) - Santa Barbara Botanic Garden
- [SD](./SD/) - University of South Dakota
- [SFSU](./SFSU/) - San Francisco State University
- [SRP](./SRP/) - Sul Ross State University
- [STNF](./STNF/) - Stephen F. Austin State University

### T-U
- [TENN](./TENN/) - University of Tennessee
- [TROY](./TROY/) - Troy University
- [UC](./UC/) - University of California system
- [UCR(temp)](./UCR(temp)/) - UC Riverside (temporary) ⚠️ *Contains parentheses*
- [UCSB](./UCSB/) - UC Santa Barbara
- [UCSC](./UCSC/) - UC Santa Cruz
- [UConn](./UConn/) - University of Connecticut
- [UNA](./UNA/) - University of North Alabama
- [UNLV](./UNLV/) - University of Nevada, Las Vegas
- [UNM](./UNM/) - University of New Mexico
- [URV](./URV/) - University of Richmond Herbarium
- [US](./US/) - United States National Herbarium
- [USCH](./USCH/) - University of South Carolina
- [USF](./USF/) - University of South Florida
- [USFWS-PRR](./USFWS-PRR/) - U.S. Fish & Wildlife Service
- [USU](./USU/) - Utah State University
- [UVSC](./UVSC/) - Utah Valley State College
- [UWAL](./UWAL/) - University of West Alabama Herbarium
- [UWEC](./UWEC/) - University of Wisconsin, Eau Claire
- [UWGB](./UWGB/) - University of Wisconsin, Green Bay
- [UWO](./UWO/) - University of Western Ontario

### V-Z
- [VPI](./VPI/) - Virginia Polytechnic Institute and State University, Massey Herbarium
- [VT](./VT/) - University of Vermont
- [WCUH](./WCUH/) - Western Carolina University
- [WIN](./WIN/) - Winona State University
- [WIS](./WIS/) - University of Wisconsin
- [WS](./WS/) - Washington State University
- [WSCO](./WSCO/) - Western State Colorado University
- [WTU](./WTU/) - University of Washington
- [WVA](./WVA/) - West Virginia University
- [WWB](./WWB/) - Western Washington University
- [YM](./YM/) - Yosemite National Park Lichen Herbarium
- [YPM](./YPM/) - Yale Peabody Museum

---

## Technical Notes

### Known Issues
- **Harvard University**: Directory name contains a space, which may cause issues in some file systems or scripts
- **UCR(temp)**: Directory name contains parentheses, potential for shell escaping issues

### Recommended Actions

1. **High Priority**: Review records with distance > 10 km (likely clear errors)
2. **Medium Priority**: Investigate 1-10 km violations (possible minor coordinate issues)
3. **Low Priority**: Verify < 1 km cases (may be due to county boundary precision)

#### Important Considerations for Data Interpretation

**Boundary Region Effects**: In areas near state or country boundaries, small apparent violation distances can result in administrative misclassification. A specimen collected just across a state line may appear as a violation when coordinates place it in the adjacent state or country, due to small inaccuracies in lat. long. values.

**Locality Text Priority**: In practice, detailed written locality descriptions are usually the most reliable indicators of actual specimen collection locations. When coordinates conflict with locality text, the written description should generally be given priority during data correction, as coordinates are more prone to transcription errors, datum conversion issues, or entry mistakes.

**Intentional Coordinate Modification**: Some coordinate discrepancies may result from intentional alteration of precise location data to prevent potentially damaging collecting activities.

### Data Currency
- **County Boundaries**: U.S. Census Bureau TIGER/Line Shapefiles (2020)
- **Analysis Date**: September 2025
- **Software**: R with sf, tigris, and dplyr packages

---

<!-- *For technical questions about the analysis methodology, see the R script: `multi_herbarium_boundary_validation_v3_09_11.R`* -->
