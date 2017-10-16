---
title: "Protein Translocation"
output: html_notebook
---

Load all required dependencies here:

```{r}
if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
}

if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
}

if (!require("MASS")) {
  install.packages("MASS", dependencies = TRUE)
}
library(fields)
library(viridis)
```

The code below demonstrates two color palettes in the [viridis](https://github.com/sjmgarnier/viridis) package. Each plot displays a contour map of the Maunga Whau volcano in Auckland, New Zealand.

## Viridis colors

```{r}
rm(list = ls())

# Define Variables Here
sim_name <- 'clpy-tmd-pull-eef1-i27'
force <- 'fmean300'

r_script_dir <- '/media/javidi/data/library/clpy/manuscripts/clpy-implicit-solvent-paper/r-scripts/implicit-solvent'
traj_dir <- paste('/media/javidi/data/library/clpy/',sim_name,'/analysis/enery-force-translocation-qn-rgyr-rms/trajs',sep = '',collapse='')

# Find and filter the list of targeted folders
setwd(traj_dir)
print(traj_dir)
print(list.dirs())
list_dirs <- list.dirs()

targeted_lsit_dirs <- grep(force,list_dirs, value = T)
print(targeted_lsit_dirs)
i <- 1
```

## Magma colors

```{r}
image(volcano, col = viridis(200, option = "A"))
```
