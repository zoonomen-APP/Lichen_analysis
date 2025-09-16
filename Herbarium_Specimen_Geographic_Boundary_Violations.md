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
| `institutionCode` | Herbarium abbreviation (e.g., OSC, DUKE, NY) |
| `recordedBy` | Collector name(s) as recorded in the original specimen data |
| `state` | State where the specimen was reportedly collected |
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

*Click on herbarium codes to view flagged record files grouped by state; records sorted by distance from county border*

### A-C
- [ALA](./data/ALA/) - University of Alaska Museum of the North Herbarium
- [APSC](./data/APSC/) - Austin Peay State University
- [ASU](./data/ASU/) - Arizona State University
- [AUA](./data/AUA/) - Auburn University, Freeman Herbarium
- [BALT](./data/BALT/) - Towson University Biodiversity Center
- [BRIT](./data/BRIT/) - Botanical Research Institute of Texas
- [BRY](./data/BRY/) - Brigham Young University
- [BUT](./data/BUT/) - Butler University
- [CAS](./data/CAS/) - California Academy of Sciences
- [CHRB](./data/CHRB/) - Rutgers University, Chrysler Herbarium
- [CHSC](./data/CHSC/) - Ahart Herbarium, CSU Chico
- [CINC](./data/CINC/) - University of Cincinnati
- [CLEMS](./data/CLEMS/) - Clemson University
- [CMN](./data/CMN/) - Canadian Museum of Nature
- [COLO](./data/COLO/) - University of Colorado
- [CSCN](./data/CSCN/) - High Plains Herbarium at Chadron State College
- [CSU](./data/CSU/) - University of Central Oklahoma Lichen Herbarium
- [CUP](./data/CUP/) - Cornell University Plant Pathology Herbarium

### D-G
- [DAV](./data/DAV/) - University of California, Davis
- [DUKE](./data/DUKE/) - Duke University
- [EVE](./data/EVE/) - Evergreen State College
- [EWU](./data/EWU/) - Eastern Washington University
- [F](./data/F/) - Field Museum of Natural History
- [FH](./data/FH/) - Harvard University Farlow Herbarium
- [FLAS](./data/FLAS/) - University of Florida
- [FTG](./data/FTG/) - Fairchild Tropical Botanic Garden
- [FTU](./data/FTU/) - University of Central Florida Herbarium
- [GAM](./data/GAM/) - University of Georgia
- [GEO](./data/GEO/) - Lichen Collection of the Emory University Herbarium
- [GMUF](./data/GMUF/) - George Mason University

### H-L
- [HPSU](./data/HPSU/) - Portland State University
- [HSC](./data/HSC/) - Cal Poly Humboldt
- [Harvard_University](./data/Harvard_University/) - Harvard University
- [ID](./data/ID/) - University of Idaho
- [IDS](./data/IDS/) - Idaho Museum of Natural History
- [ILL](./data/ILL/) - University of Illinois
- [ILLS](./data/ILLS/) - University of Illinois, Illinois Natural History Survey Fungarium
- [IND](./data/IND/) - Indiana University
- [ISC](./data/ISC/) - Iowa State University
- [KANU](./data/KANU/) - University of Kansas
- [KE](./data/KE/) - Kent State University
- [KIRI](./data/KIRI/) - University of Rhode Island
- [LSU](./data/LSU/) - Louisiana State University

### M-O
- [MAINE](./data/MAINE/) - University of Maine
- [MCTC](./data/MCTC/) - Michigan Technological University
- [MDKY](./data/MDKY/) - Morehead State University
- [MICH](./data/MICH/) - University of Michigan
- [MIL](./data/MIL/) - Milwaukee Public Museum
- [MIN](./data/MIN/) - University of Minnesota
- [MONT](./data/MONT/) - Montana State University
- [MONTU](./data/MONTU/) - University of Montana
- [MOR](./data/MOR/) - Morton Arboretum Herbarium
- [MSC](./data/MSC/) - Michigan State University
- [MU](./data/MU/) - Miami University
- [NBM](./data/NBM/) - New Brunswick Museum
- [NCU](./data/NCU/) - University of North Carolina
- [NEB](./data/NEB/) - University of Nebraska
- [NHA](./data/NHA/) - New Hampshire
- [NY](./data/NY/) - New York Botanical Garden
- [OBI](./data/OBI/) - Cal Poly State University
- [OMA](./data/OMA/) - University of Nebraska, Omaha
- [OS](./data/OS/) - Ohio State University
- [OSC](./data/OSC/) - Oregon State University

### P-S
- [PH](./data/PH/) - Academy of Natural Sciences of Drexel Univeristy, Philadelphia
- [RM](./data/RM/) - University of Wyoming, Rocky Mountain Herbarium
- [SBBG](./data/SBBG/) - Santa Barbara Botanic Garden
- [SD](./data/SD/) - San Diego Natural History Museum
- [SFSU](./data/SFSU/) - San Francisco State University
- [SRP](./data/SRP/) - Boise State University Lichen Herbarium
- [STNF](./data/STNF/) - Shasta-Trinity National Forest Herbarium

### T-U
- [TENN](./data/TENN/) - University of Tennessee
- [TROY](./data/TROY/) - Troy University
- [UC](./data/UC/) - University of California, Berkeley
- [UCR(temp)](./data/UCR(temp)/) - University of California, Riverside Lichens (in transfer to SBBG) ⚠️ *Contains parentheses*
- [UCSB](./data/UCSB/) - UC Santa Barbara
- [UCSC](./data/UCSC/) - UC Santa Cruz
- [UConn](./data/UConn/) - University of Connecticut
- [UNA](./data/UNA/) - University of Alabama
- [UNLV](./data/UNLV/) - College of Southern Nevada, Henderson Campus, Henderson
- [UNM](./data/UNM/) - University of New Mexico
- [URV](./data/URV/) - University of Richmond Herbarium
- [US](./data/US/) - United States National Herbarium
- [USCH](./data/USCH/) - University of South Carolina
- [USF](./data/USF/) - University of South Florida
- [USFWS-PRR](./data/USFWS-PRR/) - U.S. Fish & Wildlife Service Herbarium of the Patuxent Research Refuge - Maryland
- [USU](./data/USU/) - Utah State University
- [UVSC](./data/UVSC/) - Utah Valley State College
- [UWAL](./data/UWAL/) - University of West Alabama Herbarium
- [UWEC](./data/UWEC/) - University of Wisconsin, Eau Claire
- [UWGB](./data/UWGB/) - University of Wisconsin, Green Bay
- [UWO](./data/UWO/) - University of Western Ontario

### V-Z
- [VPI](./data/VPI/) - Virginia Polytechnic Institute and State University, Massey Herbarium
- [VT](./data/VT/) - University of Vermont
- [WCUH](./data/WCUH/) - Western Carolina University
- [WIN](./data/WIN/) - University of Manitoba
- [WIS](./data/WIS/) - University of Wisconsin, Wisconsin State Herbarium
- [WS](./data/WS/) - Washington State University
- [WSCO](./data/WSCO/) - Western State Colorado University
- [WTU](./data/WTU/) - University of Washington
- [WVA](./data/WVA/) - West Virginia University
- [WWB](./data/WWB/) - Western Washington University
- [YM](./data/YM/) - Yosemite National Park Lichen Herbarium
- [YPM](./data/YPM/) - Yale Peabody Museum

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
