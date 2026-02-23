# County-Level Collection Density Analysis
## 2025.12.15

### Overview

Analysis of lichen specimen collection density by county for the contiguous 48 states, using binomial names only (excluding genus-only records). Data from clh_2025_11.db with standardized countyEd values.

---

### Top Counties by Raw Count

| State | County | Records |
|-------|--------|---------|
| Michigan | Keweenaw_Co. | 19,087 |
| Oregon | Lane_Co. | 18,661 |
| California | Santa_Barbara_Co. | 17,110 |
| Minnesota | St._Louis_Co. | 13,571 |
| Colorado | Boulder_Co. | 11,696 |
| Maine | Hancock_Co. | 10,492 |
| Oregon | Douglas_Co. | 9,578 |
| Washington | Skamania_Co. | 9,430 |
| Minnesota | Cook_Co. | 8,521 |
| California | Los_Angeles_Co. | 8,404 |

---

### Top Counties by Density (Records per 1000 km²)

| State | County | Records | Area (1000 km²) | Density |
|-------|--------|---------|-----------------|---------|
| Michigan | Keweenaw_Co. | 19,087 | 1.40 | **13,645** |
| Louisiana | East_Baton_Rouge_Co. | 8,112 | 1.18 | 6,876 |
| Colorado | Boulder_Co. | 11,696 | 1.88 | 6,217 |
| Florida | Seminole_Co. | 4,274 | 0.80 | 5,334 |
| Washington | San_Juan_Co. | 2,110 | 0.45 | 4,684 |
| California | San_Francisco_Co. | 528 | 0.12 | 4,345 |
| Massachusetts | Nantucket_Co. | 451 | 0.12 | 3,770 |
| Maine | Knox_Co. | 3,217 | 0.95 | 3,402 |
| North Carolina | Haywood_Co. | 4,363 | 1.43 | 3,043 |
| Oregon | Benton_Co. | 5,139 | 1.75 | 2,939 |

**Patterns in high-density counties:**
- **Institution effect**: East Baton Rouge (LSU), Boulder (CU), Benton (OSC in Corvallis)
- **Island/small area effect**: San Francisco, Nantucket, San Juan — tiny denominators amplify counts
- **Appalachian hotspots**: Haywood, Swain, Sevier, Yancey, Jackson, Macon NC — Great Smokies

---

### Bottom Counties by Density (Lowest non-zero)

| State | County | Records | Area (1000 km²) | Density |
|-------|--------|---------|-----------------|---------|
| New Mexico | Quay_Co. | 1 | 7.44 | **0.13** |
| Colorado | Cheyenne_Co. | 1 | 4.61 | 0.22 |
| North Dakota | Hettinger_Co. | 1 | 2.93 | 0.34 |
| Texas | Hale_Co. | 1 | 2.60 | 0.38 |
| Nebraska | Frontier_Co. | 1 | 2.52 | 0.40 |
| Texas | Hill_Co. | 1 | 2.48 | 0.40 |
| Montana | Toole_Co. | 2 | 4.96 | 0.40 |
| Texas | Roberts_Co. | 1 | 2.39 | 0.42 |
| Texas | Nolan_Co. | 1 | 2.36 | 0.42 |
| Texas | King_Co. | 1 | 2.36 | 0.42 |

**Pattern**: Texas panhandle, Kansas plains, eastern Colorado/Montana — flat, dry, agricultural, unglamorous.

---

### The Density Range

- **Highest**: Keweenaw — 13,645 records per 1000 km²
- **Lowest**: Quay County NM — 0.13 records per 1000 km²
- **Ratio**: ~100,000:1

---

### The Grand Isle Story

**Vermont county summary:**

| County | Records | Taxa | Taxa/Record |
|--------|---------|------|-------------|
| Grand_Isle_Co. | 13 | 11 | 0.85 |
| Chittenden_Co. | 1,952 | 619 | 0.32 |

**Key points:**
- Grand Isle: 13 specimens comprising 11 different taxa
- Zero saturation — almost every collection is a different species
- Accessible by bridge from Burlington, visible from UVM campus
- An afternoon of collecting could double the county species count
- Chittenden County (UVM's home): 150x more records, right next door

**Geography**: Grand Isle County has NO land connection to the mainland. Located in NE corner of Lake Champlain, accessible only by bridge or boat, abuts Canadian border.

---

### Other Island Counties

| County | Records | Density | Notes |
|--------|---------|---------|-------|
| San Juan, WA | 2,110 | 4,684 | Friday Harbor Labs effect |
| Nantucket, MA | 451 | 3,770 | Field station |
| San Francisco, CA | 528 | 4,345 | Urban but small |
| Grand Isle, VT | 13 | ? | Virtually ignored |

Island counties tend toward high density (concentrated access, marine labs) — Grand Isle is the outlier.

---

### Insights for the Talk

1. **The range is staggering** — 100,000:1 density ratio means some counties are essentially terra incognita

2. **You don't need to go far** — Grand Isle is a bridge away from UVM. Quay County is on I-40.

3. **Institution proximity ≠ coverage** — Chittenden has 1,952 records; neighboring Grand Isle has 13

4. **The unglamorous matters** — Texas panhandle lichens exist. One record per county means nobody's looked.

5. **Zero saturation = pure discovery** — 11 taxa in 13 specimens means every collection adds to the list

6. **Call to action**: "You could be the first to seriously survey [X] County"

---

### Data Notes

- Source: clh_2025_11.db, narrow table
- Filter: binomial names only (scientificName contains space)
- Filter: countyEd LIKE '%_Co.' (standardized format)
- Area: ALAND from tigris county boundaries (square meters → 1000 km²)
- Date: 2025.12.15

---

### Vermont Data Quality Issues Noted

Still lurking in Vermont countyEd:
- Virginia/WV counties: Chesapeake City, Grayson, Page, Tucker
- Misspellings: Chittendon, Windson
- Wrong states: Hartford, Madison

(Not relevant to the talk, but reminder that regularization is never "done")
