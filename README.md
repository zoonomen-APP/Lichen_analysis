# Lichen Herbarium Specimen Geographic Boundary Validation

*This analysis was conducted independently by A. Peterson and is not affiliated with or endorsed by the Symbiota Support Hub or the Consortium of Lichen Herbaria (CLH).*

## What This Is

This repository contains the results of a geographic boundary check on lichen herbarium specimen records from the Consortium of Lichen Herbaria (CLH) portal. For United States records that include both a county name and latitude/longitude coordinates, I tested whether the coordinates fall within the stated county boundary. Records where they do not are flagged and listed here.

I call these flagged records "boundary violations" or "out-of-bounds" (OOB) throughout — that is the practical, working name. More precisely, each flag marks an **unresolved** relationship between a record's stated location and its recorded coordinates: the two could not be reconciled. Either the coordinate may be wrong, or the county/state may be wrong, or both, or a misspelling alone may have produced the mismatch. A flag is a discrepancy, not a diagnosis. (For why even "violation" turns out to be the right word in the hardest case, see [How to Interpret the Distance Values](#how-to-interpret-the-distance-values).)

Each flagged record includes a clickable link to the current specimen record in CLH. Note that the linked record may have been corrected — or changed in other ways — since the analysis was performed; the data shown in the flagged-record file reflects the record as it existed at the time of download. See [About the Data and These Results](#about-the-data-and-these-results) for why that matters more than it might seem.

## Browse the Data

Results are organized three ways:

- **[By Herbarium](./herbaria/)** — flagged records grouped by institution
- **[By Collector](./collectors/)** — flagged records grouped by collector name
- **[By State](./geography/by_state/)** — flagged records grouped by claimed state

**Currency note:** The **By Herbarium** results are current as of the corpus date below. The **By Collector** and **By State** views are derived partitions that have not yet been regenerated against the current corpus — they reflect an earlier run and are pending refresh. Treat them as provisional until this note is removed.

**On the groupings:** The groupings here — by institution, collector, and state — are built on the field values as recorded in CLH. I apply minimal mechanical regularization in an effort to improve grouping for the purposes of this work — for example, replacing characters that cannot appear in a folder name as part of output. I do not normalize the substance of the values — variant spellings, abbreviations, and distinct codes for what may be the same herbarium, collector, or place are left as recorded and appear as separate groups. This is deliberate: the recorded values are the object of study, and normalizing them would conceal the very irregularities that the analysis hopes to surface.

## What the Files Contain

Each flagged-record file is a tab-separated text file (`.txt`) with one row per flagged record. The fields are:

| Field | Description |
|-------|-------------|
| `id` | CLH occurrence identifier for the record |
| `institutionCode` | Herbarium abbreviation |
| `catalogNumber` | Catalog (accession) number as recorded |
| `recordedBy` | Collector name(s) as recorded |
| `recordNumber` | Collector's record number as recorded |
| `distance_km` | Distance from the coordinate to the nearest edge of the stated county boundary (see interpretation below) |
| `state` | State where the specimen was reportedly collected |
| `county` | County as recorded in the original data |
| `decimalLatitude` | Latitude as recorded |
| `decimalLongitude` | Longitude as recorded |
| `status` | Type of mismatch detected (see status codes below) |
| `implied_location` | The state and county where the coordinates actually fall |
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

**The true error is greater than or equal to the reported distance. Treat reported distances as a lower bound.** It follows that the importance of a flag cannot be inferred from its distance alone — a small distance can accompany a large real displacement, and a large distance is not automatically the most consequential case.

### What a distance of zero means

Among the flagged records in these files, `distance_km` = 0 does **not** mean the coordinate is fine. It means the coordinate falls **exactly on the stated county's boundary line**. A strict containment test counts a point on the line as not inside the county, so the record is flagged — but its distance to the boundary is zero because it sits on the boundary. These are the boundary-coincident cases: a point on a zero-width line belongs, in the model, to both adjacent counties at once and to neither, so "which county" is genuinely undefined (see [Where "violation" and "unresolved" meet](#where-violation-and-unresolved-meet) below). A `distance_km` = 0 flag marks indeterminacy, not a measured error.

(Separately, a coordinate that falls cleanly *inside* its stated county is not flagged at all and does not appear in these files. Such a record passes the boundary check but is not thereby confirmed correct — it may sit in the right county yet far from the true collection site. That caution is covered under [Important Limitations](#important-limitations).)

### Where "violation" and "unresolved" meet

The shorthand and the precise description converge at the hardest case. A county boundary is a line of zero width. A coordinate that falls *exactly on* that line is, in the model, in both adjacent counties at once and in neither — a real lichen placed there would sit in both. For such a point, "outside" versus "inside" is not merely hard to compute; it is **undefined**. So a boundary-coincident record both *violates* clean county assignment (there is no single county to assign) and is genuinely *unresolved* (it cannot be placed on one side). What begins as a practical label for a working tool turns out, at the limit, to describe a true indeterminacy. Both words are correct, and they meet on the boundary.

### Border type matters

Not all county borders carry the same consequence when crossed:

- **Internal county border**: The county boundary is entirely within a single state — not shared with a state line or coastline. The specimen is assigned to the wrong county but remains in the correct state. Least consequential for most analyses.
- **State boundary**: The county border coincides with a state line. Both county and state assignment change, potentially affecting checklists and distribution records.
- **Coastline**: The specimen falls outside all political boundaries and may be silently excluded from any analysis that clips to boundary polygons. A 50-meter error inland may move a record to a neighboring county; the same error at the coast may remove the record from a "United States" restricted analysis entirely.

Border classification by type is derivable from FIPS codes in the boundary data and is possible but not yet implemented.

### Guidance for review

- **Large distances (hundreds of km or more)**: Usually obvious errors — hemisphere flips, transposed coordinates, wrong-country assignments. Often easy to diagnose and correct.
- **Mid-range distances (10–100 km)**: The most ambiguous cases. May represent genuine geocoding errors, wrong county assignments, or confusion between similarly named places. These often deserve the most attention.
- **Small distances (under 1 km)**: May reflect coordinate rounding, GPS drift, or the inherent precision limit of boundary polygons. Many of these are functionally correct.

## Important Limitations

**Records not flagged by this analysis are not necessarily correct.** A coordinate that falls within the stated county passes the boundary check but may still be substantially wrong — placed in the correct county but far from the actual collection site. This analysis identifies records where the coordinate and county *demonstrably disagree*. It cannot validate records where they happen to agree.

**The flagged set is a subset of the total.** What is flagged is what this method, run this way, on this corpus, was able to detect. Records can be wrong in ways the method cannot see — most notably errors that remain inside the correct county. Absence of a flag is not a clean bill.

**Flagged records require individual review in context.** The flag indicates a discrepancy, not a diagnosis. The coordinate may be wrong, the county may be wrong, the state may be wrong, or some combination. The locality text, collector history, and surrounding records often provide the context needed to determine what happened. Automated flagging scales; correction does not.

**Scope is bounded by string matching.** Records are included when their state and country fields match the filters used (the conterminous 48 states plus DC, and a United States country test). These are bounded string matches, not perfect classifiers: some genuinely in-scope records carry misspelled or variant state/country values and are silently missed. The included set is what the filters caught, not the complete holdings.

**A single institution code is assumed, but the field does not always hold one.** The `institutionCode` field is treated as naming one institution. Some records, however, record *several* codes together (for example, a holding herbarium alongside a distributed-set or exsiccata code). Such a value is not a single institution — it is an aggregate of institutions — and it is matched as the exact recorded string rather than resolved into its constituents. As a result, multi-code records are grouped under none of their member institutions and are absent from each of those institutions' counts. This is one visible instance of a broader condition: the recorded fields are free text whose names assert a type the values do not always honor.

**County name matching is imperfect.** The analysis matches recorded county names to official Census Bureau county names using exact matching, standardization of common abbreviations, and fuzzy string matching. Some legitimate county names may fail to match, producing false flags. The `status` field indicates the matching method used.

**Locality text is often more reliable than coordinates.** When coordinates conflict with a detailed written locality description, the written description should generally be given priority. Coordinates are more prone to transcription errors, datum conversion issues, and data-entry mistakes.

## About the Data and These Results

**These results are a dated snapshot.** The specimen data was downloaded from CLH on the corpus date given below and frozen. Everything here describes that frozen copy.

**The source does not stand still.** CLH is a living, continuously updated resource. By the time you read a flagged record and follow its link, the live record may have been corrected, altered, or removed. The flagged file describes a *past* state of the record, not its present one.

**There is no reliable way to know where you are on the flow.** Like most such aggregators, CLH does not expose a per-record change history. Neither a reader nor I can determine, from CLH alone, how its current state relates to this snapshot — what has changed, when, or whether any given record still matches what is shown here. This is precisely why these results are frozen at a stated date: a fixed point of reference can only be had by freezing one, because the source provides none.

**Updates here are episodic, not scheduled.** This is an independent project, tended irregularly and accretively. A long quiet stretch does not mean abandonment, and a sudden refresh does not mean a new regime — it is the natural, non-continuous rhythm of the work. The revision history below is the record of that rhythm: the gap between the corpus date and the revision date tells you how fresh the underlying data is relative to the latest editing.

**A note on the irregularities.** The irregularities these results surface are in large part the natural trace of an open resource built from many hands across many decades; demanding uniformity at entry would have excluded much of what makes the corpus valuable. They are surfaced here to be understood, not faulted.

### Revision history

*(most recent first; dates approximate where noted)*

- **2026-06-07** — Refreshed **By Herbarium** results to the 2026-05-14 corpus. Scope narrowed to the conterminous 48 states + DC. Per-institution summaries reframed (unresolved / apparent-incoherence language). Added `id`, `catalogNumber`, and `recordNumber` fields; split coordinates into `decimalLatitude` / `decimalLongitude`. By-Collector and By-State partitions pending regeneration.
- **~2025–early 2026** *(approx.)* — Earlier full-corpus runs across various download dates, covering all three partitions (herbarium, collector, state). Superseded by the 2026-06-07 refresh.

## Methodology

Specimen records were downloaded from the CLH portal (<https://lichenportal.org>). For United States records with coordinates and county information, each coordinate pair was tested for containment within the stated county boundary using US Census Bureau TIGER/Line shapefiles (2020), accessed through the R `tigris` package. Distances were calculated using the EPSG:5070 (Albers Equal Area Conic) projection.

County name matching used a layered approach: exact matching, standardization of common abbreviations and suffixes, partial matching, and fuzzy string comparison with a similarity threshold of 0.6.

For further technical detail, see [Technical_details.md](./Technical_details.md).

## Possible Improvements

Directions that may be pursued (not a commitment, and not exhaustive) include:

- **Centroid-based error estimation**: Compare flagged coordinates to the centroid of accepted specimens in the stated county, giving an expected error distance to complement the current minimum-bound boundary distance.
- **Border classification**: Classify county borders as internal, state boundary, or coastline using FIPS codes, to better assess the functional consequence of a flag.
- **Regeneration of the collector and state partitions** against the current corpus.

## Data Sources

- **Specimen data**: Consortium of Lichen Herbaria (CLH) portal — corpus downloaded **2026-05-14**
- **County boundaries**: US Census Bureau TIGER/Line Shapefiles, 2020
- **Software**: R, with the `sf`, `tigris`, and `dplyr` packages

---

<appeterson37@gmail.com>

Last revised: 2026-06-07
