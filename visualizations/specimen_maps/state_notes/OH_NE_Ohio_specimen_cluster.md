# Ohio - Collection Notes

## Overview

Ohio shows a notable geographic clustering of collection activity in the northeastern counties (Summit, Portage, Geauga, and Lake Counties, near Cleveland/Cuyahoga County).

## NE Ohio Collection Cluster Analysis

### Collector Contributions

Analysis of georeferenced specimens from Summit, Portage, Geauga, and Lake Counties reveals highly concentrated collecting efforts by a small number of individuals:

| Collector | Percentage | Date Range | Period |
|-----------|------------|------------|--------|
| Wetmore, C. | 45.598% | 1960-06-21 to 1985-07-23 | 25 years |
| Tomás Curtis | 30.474% | 2016-06-09 to 2019-10-04 | 3 years |
| Fink, Bruce | 11.061% | 1914-08-06 to 1918-10-12 | 4 years |
| Shaun Pogacnik | 1.806% | 2017-08-17 to 2024-12-19 | 7 years |
| Robert A. Klips | 1.580% | 2018-07-21 to 2019-06-29 | 1 year |
| Others (17 collectors) | 9.481% | 1877-2024 | Various |

**Total collectors in region:** 22

### Key Observations

1. **Dominance of three collectors:** Wetmore, Curtis, and Fink account for 87% of georeferenced specimens in NE Ohio.

2. **Temporal pattern:** Three distinct collecting periods:
   - **Early period (1914-1918):** Bruce Fink established baseline
   - **Mid-century surge (1960-1985):** Clifford Wetmore's intensive 25-year effort
   - **Recent activity (2016-2019):** Tomás Curtis's concentrated 3-year campaign

3. **Collecting intensity:** Curtis achieved 30.5% coverage in just 3 years (2016-2019), rivaling Wetmore's 25-year effort (45.6%).

4. **Historical depth:** Earliest record from H.C. Beardslee (1877-07-18), showing 147 years of collecting history in the region.

## Data Quality Issues

### Name Standardization Problems

Multiple variants exist for the same collectors:
- **Wetmore:** appears as "Wetmore, C.", "Wetmore, Clifford M.", "Wetmore, Clifford M", "Clifford M. Wetmore"
- **Fink:** appears as "Fink, Bruce", "Bruce Fink", "Fink, B.", "B. Fink"

These name variations fragment the contribution statistics and complicate attribution analysis.

### Missing Date Information

Two collectors ("s.c." and "s.c") have georeferenced specimens but no associated collection dates, limiting temporal analysis.

## Geographic Coverage

The NE Ohio cluster represents intensive sampling of the Cleveland metropolitan region. However, this concentration may create:
- **Sampling bias:** Over-representation of NE Ohio habitats
- **Geographic gaps:** Potential under-sampling of other Ohio regions
- **Accessibility bias:** Concentration near urban centers and accessible locations

<details>
<summary>🔍 SQL Query Used (specific to local database structure)</summary>
```sql
SELECT 
    recordedByEd,
    ROUND(COUNT(*) * 100.0 / (
        SELECT COUNT(*) 
        FROM narrow 
        WHERE stateProvinceEd = 'Ohio' 
        AND countyEd IN ('Summit', 'Portage', 'Geauga', 'Lake') 
        AND decimalLatitude IS NOT NULL 
        AND decimalLongitude IS NOT NULL
    ), 3) AS percentage,
    MIN(eventDateEd) AS start_date,
    MAX(eventDateEd) AS end_date
FROM narrow
WHERE stateProvinceEd = 'Ohio'
AND countyEd IN ('Summit', 'Portage', 'Geauga', 'Lake')
AND decimalLatitude IS NOT NULL
AND decimalLongitude IS NOT NULL
GROUP BY recordedByEd
ORDER BY percentage DESC;
```

**Database:** run_88.db  
**Table:** narrow  
**Analysis date:** 2025.10.15

</details>

---
*Last updated: 2025.10.15*
