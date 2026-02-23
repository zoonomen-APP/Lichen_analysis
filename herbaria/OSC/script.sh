for dir in /c/Lichen_analysis/herbaria/*/; do
  inst=$(basename "$dir")
  file=$(ls "$dir"*summary*.txt 2>/dev/null | head -1)
  if [ -n "$file" ]; then
    rate=$(grep "Boundary violation rate" "$file" | sed 's/.*: //' | sed 's/ of.*//')
    total=$(grep "Total records in download" "$file" | sed 's/.*: //')
    median=$(grep "Median distance" "$file" | sed 's/.*: //')
    echo -e "$inst\t$total\t$rate\t$median"
  fi
done |sort -t$'\t' -k3 -n | head -20

