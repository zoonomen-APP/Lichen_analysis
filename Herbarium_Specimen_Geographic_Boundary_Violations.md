# Lichen Herbarium Specimen Geographic Boundary Validation by herbarium and by collector

## Overview

This document contains links to herbarium specimen records with 
latitude/longitude coordinates that fall outside the boundaries of 
their reported collection counties. These "out-of-bounds" records 
may result from:

- Data entry errors
- Coordinate conversion mistakes
- Incorrect locality assignments
- Combinations of the above

The severity of these discrepancies varies widely, from minor naming 
conflicts (0 km offset) to major errors such as incorrect hemispheric 
assignments (offsets of thousands of kilometers). Hemispheric errors 
are particularly common.

Data review and correction are recommended for most records, with 
priority depending on your intended use of the data.


## Methodology

### Data Processing Pipeline

1. **Data Sources**: North American herbarium specimen records from the Consortium of Lichen Herbaria portal database. 
2. **Geographic Validation**: The stated specimen record locations are validated against official U.S. county boundaries (Census Bureau, 2020)
3. **Coordinate System**: All distance from boundary calculations are performed using EPSG:5070 (Albers Equal Area Conic) projection for accurate distance measurements
4. **Boundary Matching**: County names are standardized and matched using conservative fuzzy matching algorithms

### Validation Process


#### 1. Data Filtering
- Records are limited to United States specimens based on matching the 'country' value to a wide range of variant renderings of the name.
- The records include only cases with both latitude/longitude coordinates.
- They exclude records missing state or county information
- Multi-state/county entries (e.g., "CA/NV") are filetered out.

#### 2. Geographic Analysis
- Specimen record values of 'decimalLatitude' 'decimalLongitude' are tested for containment within reported county boundaries
- Boundary violation distances are calculated from record coordinates to nearest named county boundary edge
- Violations (distance > 0 km) are reported (rare 0 km cases indicative of possible county naming conflicts are present)

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
- [ALA](./herbaria/ALA/) - University of Alaska Museum of the North Herbarium
- [APSC](./herbaria/APSC/) - Austin Peay State University
- [ASU](./herbaria/ASU/) - Arizona State University
- [AUA](./herbaria/AUA/) - Auburn University, Freeman Herbarium
- [BALT](./herbaria/BALT/) - Towson University Biodiversity Center
- [BRIT](./herbaria/BRIT/) - Botanical Research Institute of Texas
- [BRY](./herbaria/BRY/) - Brigham Young University
- [BUT](./herbaria/BUT/) - Butler University
- [CAS](./herbaria/CAS/) - California Academy of Sciences
- [CHRB](./herbaria/CHRB/) - Rutgers University, Chrysler Herbarium
- [CHSC](./herbaria/CHSC/) - Ahart Herbarium, CSU Chico
- [CINC](./herbaria/CINC/) - University of Cincinnati
- [CLEMS](./herbaria/CLEMS/) - Clemson University
- [CMN](./herbaria/CMN/) - Canadian Museum of Nature
- [COLO](./herbaria/COLO/) - University of Colorado
- [CSCN](./herbaria/CSCN/) - High Plains Herbarium at Chadron State College
- [CSU](./herbaria/CSU/) - University of Central Oklahoma Lichen Herbarium
- [CUP](./herbaria/CUP/) - Cornell University Plant Pathology Herbarium

### D-G
- [DAV](./herbaria/DAV/) - University of California, Davis
- [DUKE](./herbaria/DUKE/) - Duke University
- [EVE](./herbaria/EVE/) - Evergreen State College
- [EWU](./herbaria/EWU/) - Eastern Washington University
- [F](./herbaria/F/) - Field Museum of Natural History
- [FH](./herbaria/FH/) - Harvard University Farlow Herbarium
- [FLAS](./herbaria/FLAS/) - University of Florida
- [FTG](./herbaria/FTG/) - Fairchild Tropical Botanic Garden
- [FTU](./herbaria/FTU/) - University of Central Florida Herbarium
- [GAM](./herbaria/GAM/) - University of Georgia
- [GEO](./herbaria/GEO/) - Lichen Collection of the Emory University Herbarium
- [GMUF](./herbaria/GMUF/) - George Mason University

### H-L
- [HPSU](./herbaria/HPSU/) - Portland State University
- [HSC](./herbaria/HSC/) - Cal Poly Humboldt
- [Harvard_University](./herbaria/Harvard_University/) - Harvard University
- [ID](./herbaria/ID/) - University of Idaho
- [IDS](./herbaria/IDS/) - Idaho Museum of Natural History
- [ILL](./herbaria/ILL/) - University of Illinois
- [ILLS](./herbaria/ILLS/) - University of Illinois, Illinois Natural History Survey Fungarium
- [IND](./herbaria/IND/) - Indiana University
- [ISC](./herbaria/ISC/) - Iowa State University
- [KANU](./herbaria/KANU/) - University of Kansas
- [KE](./herbaria/KE/) - Kent State University
- [KIRI](./herbaria/KIRI/) - University of Rhode Island
- [LSU](./herbaria/LSU/) - Louisiana State University

### M-O
- [MAINE](./herbaria/MAINE/) - University of Maine
- [MCTC](./herbaria/MCTC/) - Michigan Technological University
- [MDKY](./herbaria/MDKY/) - Morehead State University
- [MICH](./herbaria/MICH/) - University of Michigan
- [MIL](./herbaria/MIL/) - Milwaukee Public Museum
- [MIN](./herbaria/MIN/) - University of Minnesota
- [MONT](./herbaria/MONT/) - Montana State University
- [MONTU](./herbaria/MONTU/) - University of Montana
- [MOR](./herbaria/MOR/) - Morton Arboretum Herbarium
- [MSC](./herbaria/MSC/) - Michigan State University
- [MU](./herbaria/MU/) - Miami University
- [NBM](./herbaria/NBM/) - New Brunswick Museum
- [NCU](./herbaria/NCU/) - University of North Carolina
- [NEB](./herbaria/NEB/) - University of Nebraska
- [NHA](./herbaria/NHA/) - New Hampshire
- [NY](./herbaria/NY/) - New York Botanical Garden
- [OBI](./herbaria/OBI/) - Cal Poly State University
- [OMA](./herbaria/OMA/) - University of Nebraska, Omaha
- [OS](./herbaria/OS/) - Ohio State University
- [OSC](./herbaria/OSC/) - Oregon State University

### P-S
- [PH](./herbaria/PH/) - Academy of Natural Sciences of Drexel Univeristy, Philadelphia
- [RM](./herbaria/RM/) - University of Wyoming, Rocky Mountain Herbarium
- [SBBG](./herbaria/SBBG/) - Santa Barbara Botanic Garden
- [SD](./herbaria/SD/) - San Diego Natural History Museum
- [SFSU](./herbaria/SFSU/) - San Francisco State University
- [SRP](./herbaria/SRP/) - Boise State University Lichen Herbarium
- [STNF](./herbaria/STNF/) - Shasta-Trinity National Forest Herbarium

### T-U
- [TENN](./herbaria/TENN/) - University of Tennessee
- [TROY](./herbaria/TROY/) - Troy University
- [UC](./herbaria/UC/) - University of California, Berkeley
- [UCR(temp)](./herbaria/UCR(temp)/) - University of California, Riverside Lichens (in transfer to SBBG) ⚠️ *Contains parentheses*
- [UCSB](./herbaria/UCSB/) - UC Santa Barbara
- [UCSC](./herbaria/UCSC/) - UC Santa Cruz
- [UConn](./herbaria/UConn/) - University of Connecticut
- [UNA](./herbaria/UNA/) - University of Alabama
- [UNLV](./herbaria/UNLV/) - College of Southern Nevada, Henderson Campus, Henderson
- [UNM](./herbaria/UNM/) - University of New Mexico
- [URV](./herbaria/URV/) - University of Richmond Herbarium
- [US](./herbaria/US/) - United States National Herbarium
- [USCH](./herbaria/USCH/) - University of South Carolina
- [USF](./herbaria/USF/) - University of South Florida
- [USFWS-PRR](./herbaria/USFWS-PRR/) - U.S. Fish & Wildlife Service Herbarium of the Patuxent Research Refuge - Maryland
- [USU](./herbaria/USU/) - Utah State University
- [UVSC](./herbaria/UVSC/) - Utah Valley State College
- [UWAL](./herbaria/UWAL/) - University of West Alabama Herbarium
- [UWEC](./herbaria/UWEC/) - University of Wisconsin, Eau Claire
- [UWGB](./herbaria/UWGB/) - University of Wisconsin, Green Bay
- [UWO](./herbaria/UWO/) - University of Western Ontario

### V-Z
- [VPI](./herbaria/VPI/) - Virginia Polytechnic Institute and State University, Massey Herbarium
- [VT](./herbaria/VT/) - University of Vermont
- [WCUH](./herbaria/WCUH/) - Western Carolina University
- [WIN](./herbaria/WIN/) - University of Manitoba
- [WIS](./herbaria/WIS/) - University of Wisconsin, Wisconsin State Herbarium
- [WS](./herbaria/WS/) - Washington State University
- [WSCO](./herbaria/WSCO/) - Western State Colorado University
- [WTU](./herbaria/WTU/) - University of Washington
- [WVA](./herbaria/WVA/) - West Virginia University
- [WWB](./herbaria/WWB/) - Western Washington University
- [YM](./herbaria/YM/) - Yosemite National Park Lichen Herbarium
- [YPM](./herbaria/YPM/) - Yale Peabody Museum

## Analyses by Collector (Under Development)

Records grouped by collector surname appearing in `recordedBy` (may include 
primary collectors, co-collectors, or team members). Errors may originate 
from map or locality interpretation, data entry, digitization, or database 
management rather than field collection.

*Click collector name → view records by state, sorted by distance.*
*Click collector name → view records by state, sorted by distance.*

**Batch Summaries:**
- [Batch Summary (Oct 17)](./collectors/batch_summary_20251017_223421.txt) - 3 collectors, 48.6K records
- [Batch Summary (Oct 18 AM)](./collectors/batch_summary_20251018_053018.txt) - 17 collectors, 143.2K records
- [Batch Summary (Oct 18 PM)](./collectors/batch_summary_20251018_151033.txt) - 12 collectors, 59.6K records
- [Batch Summary (Oct 19 AM)](./collectors/batch_summary_20251019_075139.txt) - 1 collector, 4.6K records
- [Batch Summary (Oct 19 PM)](./collectors/batch_summary_20251019_131508.txt) - 12 collectors, 34.9K records

### A-C
- [Advaita](./collectors/Advaita/) - Advaita, M.K.
- [Allen](./collectors/Allen/) - Allen
- [Berryman](./collectors/Berryman/) - Berryman
- [Boyll](./collectors/Boyll/) - Boyll
- [Brodo](./collectors/Brodo/) - Brodo
- [Buck](./collectors/Buck/) - Buck
- [Bungartz](./collectors/Bungartz/) - Bungartz, F.
- [Burnett](./collectors/Burnett/) - Burnett
- [Chesnut](./collectors/Chesnut/) - Chesnut
- [Clayden](./collectors/Clayden/) - Clayden
- [Culberson](./collectors/Culberson/) - Culberson
- [Curtis](./collectors/Curtis/) - Curtis

### D-F
- [Dey](./collectors/Dey/) - Dey
- [Esslinger](./collectors/Esslinger/) - Esslinger
- [Eversman](./collectors/Eversman/) - Eversman

### G-I
- [Geiser](./collectors/Geiser/) - Geiser
- [Gerould](./collectors/Gerould/) - Gerould
- [Glavich](./collectors/Glavich/) - Glavich
- [Goward](./collectors/Goward/) - Goward
- [Grenon](./collectors/Grenon/) - Grenon
- [Haldeman](./collectors/Haldeman/) - Haldeman
- [Hardman](./collectors/Hardman/) - Hardman
- [Harris](./collectors/Harris/) - Harris
- [Havaas](./collectors/Havaas/) - Havaas
- [Hollinger](./collectors/Hollinger/) - Hollinger
- [Holt](./collectors/Holt/) - Holt
- [Hutchinson](./collectors/Hutchinson/) - Hutchinson
- [Imshaug](./collectors/Imshaug/) - Imshaug

### J-L
- [Jovan](./collectors/Jovan/) - Jovan
- [Knudsen](./collectors/Knudsen/) - Knudsen
- [Lasselle](./collectors/Lasselle/) - Lasselle
- [Lay](./collectors/Lay/) - Lay
- [Lendemer](./collectors/Lendemer/) - Lendemer, J.C.
- [Lumbsch](./collectors/Lumbsch/) - Lumbsch
- [Lücking](./collectors/L_cking/) - Lücking

### M-O
- [Malachowski](./collectors/Malachowski/) - Malachowski
- [McCune](./collectors/McCune/) - McCune, B.P.
- [Mikulin](./collectors/Mikulin/) - Mikulin
- [Morse](./collectors/Morse/) - Morse
- [Nash](./collectors/Nash/) - Nash
- [Nelson](./collectors/Nelson/) - Nelson

### P-S
- [Perlmutter](./collectors/Perlmutter/) - Perlmutter
- [Reed](./collectors/Reed/) - Reed
- [Root](./collectors/Root/) - Root
- [Rosentreter](./collectors/Rosentreter/) - Rosentreter, R.
- [Ryan](./collectors/Ryan/) - Ryan
- [Scharnagl](./collectors/Scharnagl/) - Scharnagl
- [Schoknecht](./collectors/Schoknecht/) - Schoknecht
- [Scotter](./collectors/Scotter/) - Scotter
- [Selva](./collectors/Selva/) - Selva
- [Shushan](./collectors/Shushan/) - Shushan
- [Solano](./collectors/Solano/) - Solano
- [St. Clair](./collectors/St__Clair/) - St. Clair
- [Stone](./collectors/Stone/) - Stone

### T-Z
- [Talbot](./collectors/Talbot/) - Talbot
- [Thomson](./collectors/Thomson/) - Thomson
- [Tripp](./collectors/Tripp/) - Tripp
- [Tucker](./collectors/Tucker/) - Tucker
- [Ulrich](./collectors/Ulrich/) - Ulrich
- [Waters](./collectors/Waters/) - Waters
- [Weber](./collectors/Weber/) - Weber
- [Wetmore](./collectors/Wetmore/) - Wetmore

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
appeterson37@gmail.com
2025.10.21

<!-- *For technical questions about the analysis methodology, see the R script: `multi_herbarium_boundary_validation_v3_09_11.R`* -->
