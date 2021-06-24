#!/bin/bash
#SBATCH --job-name=ncdf_conversion # name of the job
#SBATCH --partition=defq,intel     # partition on HPC to be used
#SBATCH --time=1:30:00             # walltime (up to 96 hours)
#SBATCH --nodes=1                  # number of nodes
#SBATCH --ntasks-per-node=1        # number of tasks (i.e. parallel processes) to be started
#SBATCH --cpus-per-task=1          # number of cpus required to run the script
#SBATCH --mem-per-cpu=64G	         # memory required for process

# load required modules
module load gcc
module load openmpi
module load zlib
module load openblas/haswell/0.3.6

# Set path variables if necessary (due to local gdal installation)
export LD_LIBRARY_PATH="/home/alston92/software/gdal-3.3.0/lib:$LD_LIBRARY_PATH"
ldd /home/alston92/R/x86_64-pc-linux-gnu-library/3.6/rgdal/libs/rgdal.so

export LD_LIBRARY_PATH="/home/alston92/software/proj-8.0.1/lib:$LD_LIBRARY_PATH"
ldd /home/alston92/R/x86_64-pc-linux-gnu-library/3.6/rgdal/libs/rgdal.so


module load netcdf
module load R

cd /bigdata/casus/movement/gis_data   # where executable and data is located

date
echo "Initiating ncdf conversion script"

Rscript ml-hfi_conversion.R    # name of script

echo "ncdf conversion complete"
date
