sqlite3 -separator $'\t' C:/Lichen/SQL/clh_2025_11.db "
SELECT stateProvinceEd, countyEd, COUNT(*) as n
FROM narrow
WHERE country = 'United States'
  AND stateProvinceEd NOT IN ('Alaska', 'Hawaii', '')
  AND countyEd LIKE '%_Co.'
  AND scientificName LIKE '% %'
GROUP BY stateProvinceEd, countyEd
ORDER BY n DESC;
" > /tmp/county_counts.tsv

wc -l /tmp/county_counts.tsv
head -20 /tmp/county_counts.tsv
