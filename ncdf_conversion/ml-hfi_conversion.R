# This is a script to convert the ml-HFI ncdf file to a tiff

# PACKAGES ####
library(ncdf4)
library(sp)
library(rgdal)
library(raster)

# DATA ####
# Specify filepath, filename, and variable of interest #
ncpath <- "/bigdata/casus/movement/gis_data/"
ncname <- "ml_hfi_v1_2019"  
ncfname <- paste(ncpath, ncname, ".nc", sep="")
dname <- "__xarray_dataarray_variable__"

# Open the file and check metadata #
ncin <- nc_open(ncfname)
print(ncin)

# Specify variables of interest #
lon <- ncvar_get(ncin,"lon")
lat <- ncvar_get(ncin,"lat")
hfi <- ncvar_get(ncin,"__xarray_dataarray_variable__")

# Close to clear up memory #
nc_close(ncin)
rm(ncin)

# Convert variable of interest into a vector and make sure missing values are denoted as NA #
hfi.vec <- as.vector(hfi)
hfi.vec[is.nan(hfi.vec)] <- NA

# Check length of vector (optional) #
# length(hfi.vec.long)

# Create a data.frame with longitude*latitude #
hfi_final <- as.data.frame(expand.grid(lon, lat))
rm(lon, lat, hfi, ncin)
names(hfi_final) <- c("long", "lat")

hfi_final$hfi <- hfi.vec.long
rm(hfi.vec.long)

# save data frame to csv (optional) #
# write.csv(hfi_final, "/bigdata/casus/movement/gis_data/ml-hfi.csv")

# Assign coordinates and CRS#
coordinates(hfi_final) <- ~long + lat
proj4string(hfi_final) <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
gridded(hfi_final) <- TRUE

# Convert to raster format
r <- raster(hfi_final)

# Save as .tif #
writeRaster(r,"ml-hfi_v1_2019.tif")
