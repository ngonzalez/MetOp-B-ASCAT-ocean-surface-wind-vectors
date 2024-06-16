FROM rocker/rstudio

# apt
RUN apt-get update -yqq
RUN apt-get install -yqq gdal-bin libgdal-dev proj-bin libnetcdf-dev libudunits2-dev

# entrypoint
COPY .docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /r

# NETCDF_PATH
ARG netcdf_path="/mnt/data/netcdf"
ENV NETCDF_PATH $netcdf_path

COPY ../displayData.R .

ENTRYPOINT []
CMD ["/usr/bin/entrypoint.sh", "--process"]
