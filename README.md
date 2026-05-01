# Spotify Descriptive Statistics

Statistical analysis of the `spotify_stat3120.xls` dataset for STAT 3120.
Authors: Matthew, Sam, Andrew.

## Contents

- `Spotify_Analysis.qmd` — Quarto source file with all R code (descriptive stats, plots, multiple linear regression with diagnostics, chi-square test of independence).
- `Spotify_Analysis.pdf` — pre-rendered PDF version of the report. Open this if you just want to read the results without running R.
- `Data/spotify_stat3120.xls` — input dataset

## Requirements

- R (>= 4.0)
- RStudio (recommended) or the Quarto CLI
- A working LaTeX install (e.g. TinyTeX) for PDF output. From R you can install it with:

```r
  install.packages("tinytex")
  tinytex::install_tinytex()
```

## Installing the R packages

The first code chunk in the `.qmd` contains the install line, commented out:

```r
#install.packages(c("readxl", "dplyr", "ggplot2", "janitor", "epitools", "gt", "car"))
```

The first time you run the project, **uncomment that line** (remove the leading `#`) and run that chunk once to install the seven packages. After they are installed you can re-comment the line so the packages are not reinstalled on every render.

## Running the code

### Option A — RStudio

1. Open `Spotify_Analysis.qmd` in RStudio.
2. Make sure `spotify_stat3120.xls` is inside a `Data/` folder next to the `.qmd` (the script loads it with `read_excel("Data/spotify_stat3120.xls")`).
3. Run the install chunk once (see above).
4. Click **Render** to produce the PDF, or use the green play buttons to run chunks one at a time.

### Option B — Command line (Quarto CLI)

From the folder containing the `.qmd`:

```bash
quarto render Spotify_Analysis.qmd
```

This will produce `Spotify_Analysis.pdf` in the same folder.

### Option C — Run chunk-by-chunk in RStudio (no rendering)

If you just want to see the output interactively without producing a PDF:

1. Open `Spotify_Analysis.qmd` in RStudio.
2. Make sure `spotify_stat3120.xls` is inside a `Data/` folder next to the `.qmd`.
3. Run the install chunk once (see above) if you haven't already.
4. Click the green ▶ button at the top right of each code chunk to run it, or place your cursor inside a chunk and press **Ctrl + Shift + Enter** (Windows/Linux) or **Cmd + Shift + Enter** (macOS). Output (tables, plots, summaries) will appear inline below each chunk and in the Plots / Console panes — no LaTeX or rendering required.

## Rendered PDF

A pre-rendered copy of the report is included as `Spotify_Analysis.pdf`. It contains all summary statistics, plots, the multiple linear regression output with diagnostic plots (Residuals vs Fitted, Q-Q residuals, Scale-Location, Residuals vs Leverage, VIF), and the chi-square test of independence with observed and expected counts.