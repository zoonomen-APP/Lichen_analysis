# Coordinate Error Investigation: Summary of Findings

## 2025.01.15

---

## What We Set Out To Do

Investigate the relationship between detectable coordinate errors (those that fail county boundary checks) and undetectable "silent" errors (wrong coordinates that still fall within the stated county). The goal: estimate how much coordinate error is hidden in data that appears correct.

---

## What We Did

### 1. Analyzed Transcription Error Displacement

We systematically calculated how far a single-digit 0↔8 transcription error displaces a point, depending on which digit position contains the error.

**Key finding:** The third decimal place is the danger zone.

| Position | Displacement | Character |
|----------|--------------|-----------|
| Degree ones | ~890 km | NOISY — always caught |
| 1st decimal | ~89 km | NOISY — usually caught |
| 2nd decimal | ~8.9 km | BORDERLINE — may cross county |
| 3rd decimal | ~890 m | SILENT — within county |
| 4th decimal | ~89 m | SILENT — undetectable |
| 5th-6th decimal | <10 m | SILENT — inconsequential |

### 2. Identified the Truncation Trap

A particularly insidious error pattern: an 8 misread as 0, then truncated as a trailing zero.

```
45.12800 → 45.12000 → stored as 45.12
```

The error is amplified (from 8m to 8.9 km), and the evidence is destroyed. The coordinate looks cleaner and more precise than the original.

### 3. Ran a Calibration Simulation

Using OSC Lane County, Oregon as a test case:
- 13,986 records that passed county boundary check
- Introduced random 0↔8 errors at various probabilities
- Tested whether corrupted coordinates escaped or stayed inside county

**Result:** The silent-to-OOB ratio was remarkably stable at approximately **6:1** across all error probabilities tested.

For every small transcription error that escapes the county (and becomes detectable), roughly six stay inside (and remain hidden).

### 4. Analyzed 48-State OOB Patterns

Extracted violation breakdowns for all states:

| Violation Type | What It Means |
|----------------|---------------|
| COUNTY | Wrong county, right state — small-to-modest errors |
| STATE | Wrong state — larger errors |
| COUNTRY | Off the map — sign errors, wrong hemisphere |

**Finding:** COUNTY violations dominate in most states (70-95% of all OOB), but the proportion varies with geography:
- Large-county western states: mostly COUNTY violations
- Small-county eastern states: more STATE violations (errors escape more easily)
- Coastal/border states: more COUNTRY violations (escape to ocean or Canada)

### 5. Estimated Silent Error Rates by State

Applying the 6:1 ratio to COUNTY violations only:

| Category | Estimated Silent Error Rate | Example States |
|----------|----------------------------|----------------|
| High | 30-37% | Montana, Colorado, Idaho |
| Moderate-high | 24-26% | Oregon, Washington, Florida |
| Moderate | 15-22% | California, Arizona, Texas |
| Lower | 6-14% | Michigan, Minnesota, New York |
| Lowest | 1-5% | Maryland, Connecticut, Delaware |

**Key insight:** States with larger counties have higher silent error rates — the same errors that would escape a small county stay hidden in a large one.

---

## What We Found

### The Iceberg Metaphor

Out-of-bounds errors are the visible tip. For every coordinate error large enough to escape a county boundary, multiple errors remain hidden within.

The ratio depends on:
- County size (larger → more hidden)
- Error magnitude distribution (smaller errors → more hidden)
- Geographic position (near borders → more escape)

### The Detectability Gradient

| Error Type | Example | Escape Rate | Detection |
|------------|---------|-------------|-----------|
| Sign error | -122 → +122 | ~100% | Always caught |
| Degree error | 44 → 48 | ~100% | Always caught |
| 1st decimal | 44.1 → 44.8 | ~80% | Usually caught |
| 2nd decimal | 44.12 → 44.18 | ~50% | Sometimes caught |
| 3rd decimal | 44.123 → 44.183 | ~15% | Rarely caught |
| 4th+ decimal | 44.1234 → 44.1238 | ~0% | Never caught |

### Prior Censoring

The data we analyze has already been filtered — collectors, herbarium staff, database validation, and portal checks have removed the most obvious errors. What remains is enriched for silent errors. Our estimates are therefore **conservative**.

### Sources of Error Beyond Transcription

Our simulation modeled transcription errors, but coordinate problems also arise from:

- **Datum mismatch** — NAD27 coordinates treated as NAD83 (10-100m offset)
- **Geocoding ambiguity** — "White Mountains" assigned to one county when the actual site was in another
- **Map-derived coordinates** — 1970s topo map reading recorded with GPS-level decimal places
- **Coordinate imputation** — algorithmically assigned centroids or estimated locations

These are invisible in the data. A coordinate with six decimal places might be a genuine GPS reading or a guess from a paper map. You can't tell by looking.

---

## The Core Message

**Precision is not accuracy, and can actively mask errors.**

Six decimal places radiates false authority. But:
- Five of those six places are in the zone where transcription errors are undetectable
- The decimal places don't encode provenance
- County-as-checksum catches the noisy errors and misses the silent ones

---

## Implications

### For Data Users

- Don't trust coordinates just because they look precise
- Consider using text locality descriptions as a check — they're robust and auditable
- Be aware that clipping/filtering to a region may exclude legitimate records AND hide errors

### For Data Quality Assessment

- OOB analysis reveals the tip of the iceberg, not the whole iceberg
- Silent error rates scale with county size
- Different states/regions have different error signatures

### For the Field

- Record locality descriptions, not just coordinates
- Note coordinate source and precision in metadata
- GPS readings and map estimates are not equivalent, even if they have the same number of decimal places

---

## What We Didn't Do (Future Directions)

1. **Test other error types** — 1↔7, 3↔8, transposition errors. Would the 6:1 ratio hold?

2. **Model the full error distribution** — Use the actual OOB distance distribution to decompose errors by magnitude class.

3. **Analyze by herbarium** — Some herbaria have systematically better or worse coordinates. Compare OSC vs. NY vs. small regional collections.

4. **Investigate specific error signatures** — The "44.0, -122.0" pattern in Lane County suggests placeholder or centroid coordinates. How common is this?

5. **Maine border study** — Quantify how many records fall into Canada due to small coordinate errors. This is consequential — those records become invisible in US-only analyses.

6. **Temporal analysis** — Are coordinates from different eras systematically different in quality? Pre-GPS vs. post-GPS?

---

## Files Produced

| File | Location | Purpose |
|------|----------|---------|
| `lane_county_error_simulation.R` | `scripts/` | Simulation code |
| `Silent_Error_Estimation_Notes.md` | `docs/` | Lab notebook |
| `lane_county_calibration_results.txt` | `data/derived/` | Simulation output |
| `all_state_summaries.txt` | `data/raw/` | State-level OOB summaries |

---

## Quotable Takeaways

> "You can't tell by looking. The decimal places don't encode the provenance."

> "For every coordinate error you catch, six stay hidden."

> "Precision is not accuracy — and can actively mask errors."

> "The more decimal places, the more places for silent errors to hide."

---

*Investigation conducted 2025.01.15, Claude conversation*
