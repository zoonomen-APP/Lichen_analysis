# Lichen Herbarium Specimen Location Visualizations

This directory contains geographic distribution maps and other visualizations derived from lichen herbarium specimen data downloaded from the Consortium of Lichen Herbaria (https://lichenportal.org/portal/index.php).

## Directory Structure

### Specimen Maps (`specimen_maps/`)

Geographic distribution maps showing collection localities for herbarium specimens across the contiguous United States.

**Contents:**
- **Regional_Plots_Preview.md** - National overview (48 states) and 4 regional maps (West, Midwest, South, Northeast)
- **State_Plots_Preview.md** - Individual distribution maps for all 48 contiguous states
- **regional_plots/** - PNG and PDF files for regional maps
- **state_plots/** - PNG and PDF files for individual state maps

**Map Features:**
- **Coordinate precision:** 2 decimal places (≈1.1 km)
- **Jitter:** Scale-dependent Gaussian jitter to separate overlapping points
  - National: 0% (no jitter)
  - Regional: 0.05%
  - State: 0.1%
- **Boundaries:** State boundaries (black, prominent) and county boundaries (gray, subtle)
- **Formats:**
  - PNG (200 DPI) - optimized for web viewing and documentation
  - PDF (vector) - high quality for optimal viewing, printing and detailed examination

**Legend Information:**
State maps include both:
- Number of records plotted (those with coordinates)
- Total records estimated for the state (including those without coordinates)
- Percentage of records that could be plotted

 Older records often lack georeferencing and thus sampling may appear sparse even in the presence of good representation.

## Data Source

Maps are generated from North American herbarium specimen data ( my file: NA_herb_09_10A.txt) containing over 2.7 million records and over 1.6 million with geographic coordinates. Some corrections and data regularization are present, but much of the data is "as is" from the CLH downloads.

## Usage

View the markdown preview files (`.md`) in any markdown viewer or in GitHub to see embedded images.
There are also clickable PDF links for high-resolution versions.


---

*Last updated: October 14, 2025*
