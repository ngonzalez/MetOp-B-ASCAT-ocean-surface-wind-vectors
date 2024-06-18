packages <- c('ncdf4', 'oce')
install.packages(setdiff(packages, rownames(installed.packages())))

library(ncdf4)
library(oce)

if (length(commandArgs(trailingOnly=TRUE))>0) {
  args <- commandArgs(trailingOnly=TRUE)
  selected <- args[1]
} else {
  stop("Missing selected variable argument", call.=FALSE)
}

setwd(Sys.getenv('NETCDF_PATH'))

fnames <- list.files(pattern = "*.nc$", all.files = FALSE)

for (file in fnames) {

  nc <- nc_open(file)

  # selected
  nc_vars <- names(nc$var)
  variable <- grep(selected, nc_vars, value=TRUE)

  # variables
  time    <- nc$var$time
  size    <- time$size
  ndims   <- time$ndims
  nt      <- size[ndims]

  filename <- paste(file, variable, ".pdf")
  pdf(file=filename)

  for (i in 1:nt) {
    start <- rep(1, ndims)
    start[ndims] <- i

    count <- size
    count[ndims] <- 1

    lat <- ncvar_get(nc, varid = 'lat', start = start, count = count)
    lon <- ncvar_get(nc, varid = 'lon', start = start, count = count)

    values <- ncvar_get(nc, varid = variable, start = start, count = count)
    nc_attributes <- ncatt_get(nc, varid = variable)
  
    sinSpeed <- sin(values)
    cosSpeed <- cos(values)

    plotSticks(lon, lat, sinSpeed, cosSpeed)

    mtext(paste(nc_attributes$long_name, nc_attributes$units), side = 3)
  }

  dev.off()
}
