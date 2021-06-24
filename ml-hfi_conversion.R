# This is a script to convert the ml-HFI ncdf file to a tiff

# PULL IN ml-HFI DATA ####
library(ncdf4)
# library(RColorBrewer)
library(sp)
library(rgdal)
library(raster)

ncpath <- "/bigdata/casus/movement/gis_data/"
ncname <- "ml_hfi_v1_2019"  
ncfname <- paste(ncpath, ncname, ".nc", sep="")
dname <- "__xarray_dataarray_variable__"

ncin <- nc_open(ncfname)
# print(ncin)

lon <- ncvar_get(ncin,"lon")
lat <- ncvar_get(ncin,"lat")
hfi <- ncvar_get(ncin,"__xarray_dataarray_variable__")

# image(lon, lat, hfi, col=rev(brewer.pal(10,"RdBu")))

nc_close(ncin) ### Clears up some memory

#Convert into vector form #
hfi.vec.long <- as.vector(hfi)
hfi.vec.long[is.nan(hfi.vec.long)] <- NA

# Check length of vector #
# length(hfi.vec.long)

# Create a matrix with longitude*latitude #
hfi_final <- as.data.frame(expand.grid(lon, lat))
rm(lon, lat, hfi, ncin)
names(hfi_final) <- c("long", "lat")

hfi_final$hfi <- hfi.vec.long
rm(hfi.vec.long)

##### save data frame to csv ######
# write.csv(hfi_final, "/bigdata/casus/movement/gis_data/ml-hfi.csv")

coordinates(hfi_final) <- ~long + lat

proj4string(hfi_final) <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")

gridded(hfi_final) <- TRUE

r <- raster(hfi_final)

writeRaster(r,"ml-hfi_v1_2019.tif")
