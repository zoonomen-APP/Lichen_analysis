# Geographic Boundary Violations by State

This directory contains lichen herbarium specimen records from the Consortium of Lichen Herbaria (CLH) that exhibit geographic boundary mismatches - cases where the recorded coordinates do not align with the stated collection location.

## Data Source

- **Source:** Consortium of Lichen Herbaria (CLH)
- **Scope:** United States specimens only
- **Primary Download Date:** 2025.06.17
- **Herbarium-Specific Updates:**
  - OSC: Updated 2025.10.20
  - MAINE: Updated 2025.10.20
  
*Note: The majority of records reflect CLH data as of 2025.06.17. OSC and MAINE were updated separately to incorporate recent error corrections and new specimen additions. Future comprehensive updates will depend on changes to CLH data access methods.*

## Error Classification

Records are classified into four error types based on the severity of the geographic mismatch:

### COUNTRY (Priority 1000)
Coordinates place the specimen in a different country than the United States, or cannot be matched to any US location. These represent the most severe geographic discrepancies.

### OFFSHORE (Priority 900)
Coordinates fall in ocean, water bodies, or areas outside US territorial boundaries but were claimed to be collected within a US state.

### STATE (Priority 100)
Coordinates place the specimen in a different US state than the one recorded in the collection data.

### COUNTY (Priority 10)
Coordinates place the specimen in a different county than recorded, but within the correct state. These represent the least severe boundary violations.

## File Organization

### Directory Structure
```
by_state/
├── Alabama/
│   ├── Alabama_COUNTRY_violations.tsv
│   ├── Alabama_STATE_violations.tsv
│   └── Alabama_COUNTY_violations.tsv
├── Alaska/
│   ├── Alaska_COUNTRY_violations.tsv
│   ├── Alaska_STATE_violations.tsv
│   └── Alaska_COUNTY_violations.tsv
...
```

Each state directory contains 2-4 files depending on which error types are present:
- `[STATE]_COUNTRY_violations.tsv` (if present)
- `[STATE]_OFFSHORE_violations.tsv` (coastal states only, if present)
- `[STATE]_STATE_violations.tsv` (if present)
- `[STATE]_COUNTY_violations.tsv` (if present)

### File Format

All files are tab-separated values (TSV) with the following columns:

1. **error_type** - Classification of the boundary violation
2. **priority** - Numeric priority (1000, 900, 100, or 10)
3. **herbarium** - Herbarium code
4. **id** - Record identifier
5. **recordedBy** - Collector name
6. **state** - Claimed state
7. **county** - Claimed county
8. **distance_km** - Distance from claimed location to actual coordinates (kilometers)
9. **status** - Validation status
10. **implied_location** - Location implied by coordinates
11. **coordinates** - Decimal latitude, longitude
12. **catalogNumber** - Specimen catalog number
13. **locality** - Collection locality description
14. **record_link** - URL to full specimen record

### Sort Order

Within each file, records are sorted by `distance_km` in descending order, placing the most egregious violations (largest geographic discrepancies) at the top of each file.
