FROM ghcr.io/rocker-org/binder:latest

LABEL org.opencontainers.image.source="https://github.com/e-kotov/spanishoddata-playground"

RUN install2.r --error --skipinstalled --ncpus -4 flowmapper flowmapblue mapgl mapSpain hexSticker duckdb sf remotes httr2 parallelly memuse xml2 here curl quarto spanishoddata scales furrr future future.mirai tidyverse

RUN echo 'SPANISH_OD_DATA_DIR=~/spanish_od_data' >> ~/.Renviron

EXPOSE 8888

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser"]
