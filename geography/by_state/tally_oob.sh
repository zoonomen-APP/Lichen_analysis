#!/bin/bash
# tally_oob.sh
# Tally OOB violations across the by_state tree.
# Run from /c/Lichen_analysis/geography/by_state/ (or pass the path as $1).

set -e

ROOT="${1:-.}"
cd "$ROOT"

# Header for the per-state table
printf "%-20s %10s %10s %10s %10s\n" "state" "COUNTRY" "STATE" "COUNTY" "TOTAL"
printf "%-20s %10s %10s %10s %10s\n" "-----" "-------" "-----" "------" "-----"

# Running totals
grand_country=0
grand_state=0
grand_county=0

# Iterate state directories in sorted order
for d in */; do
    state="${d%/}"
    
    # Skip anything that isn't a state directory (no violations files inside)
    [ -z "$(ls "$d"*_violations.tsv 2>/dev/null)" ] && continue
    
    # Each file: line count minus 1 for header. Missing file counts as 0.
    country_file="${d}${state}_COUNTRY_violations.tsv"
    state_file="${d}${state}_STATE_violations.tsv"
    county_file="${d}${state}_COUNTY_violations.tsv"
    
    country=$([ -f "$country_file" ] && echo $(($(wc -l < "$country_file") - 1)) || echo 0)
    state_v=$([ -f "$state_file"   ] && echo $(($(wc -l < "$state_file")   - 1)) || echo 0)
    county=$([ -f "$county_file"  ] && echo $(($(wc -l < "$county_file")  - 1)) || echo 0)
    
    total=$((country + state_v + county))
    
    printf "%-20s %10d %10d %10d %10d\n" "$state" "$country" "$state_v" "$county" "$total"
    
    grand_country=$((grand_country + country))
    grand_state=$((grand_state + state_v))
    grand_county=$((grand_county + county))
done

grand_total=$((grand_country + grand_state + grand_county))

printf "%-20s %10s %10s %10s %10s\n" "-----" "-------" "-----" "------" "-----"
printf "%-20s %10d %10d %10d %10d\n" "TOTAL" "$grand_country" "$grand_state" "$grand_county" "$grand_total"
