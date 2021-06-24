# Converting .ncdf files into .tif files using R

Network Common Data Form (aka netCDF or .ncdf) files are a standard file format used to store meteorological data because of their ability to handle multidimensional data sets (e.g., temperature, wind speed, relative humidity, etc. at a given location). But if you're interested in only one dimension (say, temperature), one-dimensional raster files (e.g., GeoTIFFs) might be a better format for your analytical workflows.

This directory contains two scripts that can be used to convert a .ncdf file into a .tif file: (1) an R script, and (2) a supplementary bash script that can be modified to run the R script on an HPC (this will be helpful if you don't have enough RAM to handle the conversion process). In this script, I convert the .ncdf files containing the [ml-HFI data set produced by Keyes et al.](https://doi.org/10.1088/1748-9326/abe00a) into a .tif, but this should work for other data sets as well with minor modifications.

Good luck, and let me know if you have any suggestions for improving the code or code comments.
