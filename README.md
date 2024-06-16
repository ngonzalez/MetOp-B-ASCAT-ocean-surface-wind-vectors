##### Process NetCDF Data

```shell
export NETCDF_PATH=/mnt/data/netcdf
```

```shell
docker build . -t ocean-surface-wind-vectors \
  --build-arg netcdf_path=$NETCDF_PATH \
  -f .docker/Dockerfile
```

```shell
docker run --rm -it -v /data:/mnt/data ocean-surface-wind-vectors
```

Data available at Nasa Earthdata:

[earthdata.nasa.gov](https://cmr.earthdata.nasa.gov/search/concepts/C2075141559-POCLOUD.html)
