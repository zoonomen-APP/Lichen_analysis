awk -F'\t' '
NR==FNR && NR>1 {
  # tigris: state_name=$9, NAME=$4, ALAND=$6
  key = $9 "_" $4
  area[key] = $6 / 1000000000  # convert m² to 1000 km²
  next
}
{
  # counts: stateProvinceEd=$1, countyEd=$2, n=$3
  state = $1; gsub(/_/, " ", state)
  county = $2; gsub(/_Co\.$/, "", county); gsub(/_/, " ", county)
  key = state "_" county
  if (key in area && area[key] > 0) {
    density = $3 / area[key]
    print $1 "\t" $2 "\t" $3 "\t" area[key] "\t" density
  }
}' /c/Lichen/county_regularization/data/tigris/tigris_county_reference_with_states.tsv /tmp/county_counts.tsv | sort -t$'\t' -k5 -rn | head -30
