packages <- c('ncdf4', 'oce')
install.packages(setdiff(packages, rownames(installed.packages())))

library(ncdf4)
library(oce)

if (length(commandArgs(trailingOnly=TRUE))>0) {
  args <- commandArgs(trailingOnly=TRUE)
  selected <- args[1]
} else {
  stop("NETCDF_PATH is missing", call.=FALSE)
}

setwd(Sys.getenv('NETCDF_PATH'))

fnames <- list.files(pattern = "*.nc$", all.files = FALSE)

for (file in fnames) {
  nc <- nc_open(file)

  v <- nc$var$time
  size <- v$size
  ndims <- v$ndims
  nt  <- size[ndims]

  filename <- paste(file, ".pdf")
  pdf(file=filename)

  i <- 1
  for (i in 1:nt) {
    start <- rep(1, ndims)
    start[ndims] <- i

    count <- size
    count[ndims] <- 1

    lat <- ncvar_get(nc, varid = 'lat', start = start, count = count)
    lon <- ncvar_get(nc, varid = 'lon', start = start, count = count)

    wind_speed <- ncvar_get(nc, varid = 'wind_speed', start = start, count = count)
  
    sinSpeed <- sin(wind_speed)
    cosSpeed <- cos(wind_speed)

    plotSticks(lon, lat, sinSpeed, cosSpeed, add = i>1)
  }

  nc_attributes <- ncatt_get(nc, varid = 'wind_speed')
  mtext(paste(nc_attributes$long_name, nc_attributes$units), side = 2)

  dev.off()
}
