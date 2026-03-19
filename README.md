# Lichen Herbarium Specimen Geographic Boundary Validation

*This analysis was conducted independently by A. Peterson and is not affiliated with or endorsed by the Symbiota Support Hub or the Consortium of Lichen Herbaria (CLH).*

## What This Is

This repository contains the results of a geographic boundary check on lichen herbarium specimen records from the Consortium of Lichen Herbaria (CLH) portal. For United States records that include both a county name and latitude/longitude coordinates, I tested whether the coordinates fall within the stated county boundary. Records where they do not are flagged and listed here.

Each flagged record includes a clickable link to the current specimen record in CLH. Note that the linked record may have been corrected since the analysis was performed; the data shown in the violation file reflects the record as it existed at the time of download.

## Browse the Data

Results are organized three ways:

- **[By Herbarium](./herbaria/)** — flagged records grouped by institution
- **[By Collector](./collectors/)** — flagged records grouped by collector name
- **[By State](./geography/by_state/)** — flagged records grouped by claimed state

## What the Files Contain

Each violation file is a tab-separated text file with one row per flagged record. The key fields are:

| Field | Description |
|-------|-------------|
| `institutionCode` | Herbarium abbreviation |
| `recordedBy` | Collector name as recorded |
| `state` | State where the specimen was reportedly collected |
| `county` | County as recorded in the original data |
| `distance_km` | Distance from the coordinate to the nearest edge of the stated county boundary (see interpretation below) |
| `status` | Type of mismatch detected |
| `implied_location` | The state and county where the coordinates actually fall |
| `coordinates` | Latitude, longitude as recorded |
| `locality` | Locality description from the original record |
| `record_link` | Clickable URL to the current specimen record in CLH |

Within each file, records are sorted by distance from the county boundary, largest first.

### Status Codes

- **`outside_boundary_exact`** — County name matched exactly; coordinate falls outside that county
- **`outside_boundary_standardized`** — County name matched after standardizing abbreviations (e.g., "Co." to "County")
- **`outside_boundary_partial_match`** — County name partially matched
- **`outside_boundary_similarity_[score]`** — County name matched by fuzzy string comparison
- **`county_not_matched_no_match`** — County name could not be matched to any official county in the stated state

## How to Interpret the Distance Values

### The reported distance is a minimum, not an estimate

The `distance_km` value is the shortest distance from the flagged coordinate to the nearest edge of the stated county boundary. This is the **minimum possible error** — the smallest distance the coordinate would need to move to enter the stated county.

The actual distance between the reported coordinate and the correct collection location is almost certainly larger. The boundary distance equals the true error only in the uncommon case where the correct location is immediately inside the county border. For specimens collected near the interior of a county, the true error may be many times the reported distance.

**The true error is greater than or equal to the reported distance. Treat reported distances as a lower bound.**

### What a distance of zero means

A record with distance_km = 0 means the coordinate falls within the stated county. **This does not confirm that the coordinate is correct** — only that the coordinate and county are not in detectable disagreement. A specimen from a mountain summit geocoded to a valley 80 km away will show distance_km = 0 if both locations are in the same county.

### Border type matters

Not all county borders carry the same consequence when crossed:

- **Internal county border**: The county boundary is entirely within a single state — not shared with a state line or coastline. The specimen is assigned to the wrong county but remains in the correct state. Least consequential for most analyses.
- **State boundary**: The county border coincides with a state line. Both county and state assignment change, potentially affecting checklists and distribution records.
- **Coastline**: The specimen falls outside all political boundaries and may be silently excluded from any analysis that clips to boundary polygons. A 50-meter error with an inland value may move the record location to a neighboring county; the same error at the coast may remove the record from a "United States" restricted analysis completely.

Border classification by type is derivable from FIPS codes in the boundary data and is planned but not yet implemented.

### Guidance for review

- **Large distances (hundreds of km or more)**: Usually obvious errors — hemisphere flips, transposed coordinates, wrong-country assignments. Often easy to diagnose and correct.
- **Mid-range distances (10-100 km)**: The most ambiguous cases. May represent genuine geocoding errors, wrong county assignments, or confusion between similarly named places. These often deserve the most attention.
- **Small distances (under 1 km)**: May reflect coordinate rounding, GPS drift, or the inherent precision limit of boundary polygons. Many of these are functionally correct.

## Important Limitations

**Records not flagged by this analysis are not necessarily correct.** A coordinate that falls within the stated county passes the boundary check but may still be substantially wrong — placed in the correct county but far from the actual collection site. This analysis identifies records where the coordinate and county *demonstrably disagree*. It cannot validate records where they happen to agree.

**Flagged records require individual review in context.** The flag indicates a discrepancy, not a diagnosis. The coordinate may be wrong, the county may be wrong, the state may be wrong, or some combination. The locality text, collector history, and surrounding records often provide the context needed to determine what happened. Automated flagging scales; correction does not.

**County name matching is imperfect.** The analysis attempts to match recorded county names to official Census Bureau county names using exact matching, standardization of common abbreviations, and fuzzy string matching. Some legitimate county names may fail to match, producing false flags. The `status` field indicates the matching method used.

**Locality text is often more reliable than coordinates.** When coordinates conflict with a detailed written locality description, the written description should generally be given priority. Coordinates are more prone to transcription errors, datum conversion issues, and data entry mistakes.

## Methodology

Specimen records were downloaded from the CLH portal (https://lichenportal.org). For United States records with coordinates and county information, each coordinate pair was tested for containment within the stated county boundary using US Census Bureau TIGER/Line shapefiles (2020) accessed through the R `tigris` package. Distances were calculated using the EPSG:5070 (Albers Equal Area Conic) projection for accuracy.

County name matching used a layered approach: exact matching, standardization of common abbreviations and suffixes, partial matching, and fuzzy string comparison with a similarity threshold of 0.6.

For full technical details including R code and projection specifications, see [Technical_details.md](./Technical_details.md).

## Planned Improvements

- **Centroid-based error estimation**: Compare flagged coordinates to the centroid of accepted specimens in the stated county, providing an expected error distance to complement the current minimum-bound boundary distance.
- **Border classification**: Classify county borders as internal, state boundary, or coastline using FIPS codes, to better assess the functional consequence of boundary violations.

## Data Sources and Currency

- **Specimen data**: Consortium of Lichen Herbaria (CLH) portal, various download dates 2025-2026
- **County boundaries**: US Census Bureau TIGER/Line Shapefiles, 2020
- **Software**: R with sf, tigris, and dplyr packages

---

appeterson37@gmail.com
2026.03.19
