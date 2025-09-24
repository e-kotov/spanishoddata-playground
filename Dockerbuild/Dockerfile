FROM ghcr.io/rocker-org/binder:latest

# become root so apt-get works
USER root

# install system tools
RUN apt-get update \
 && apt-get install -y --no-install-recommends software-properties-common \
 && add-apt-repository universe \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      gh git htop mc micro nano \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# drop back to notebook user (optional but recommended)
USER $NB_USER

# install R packages
RUN install2.r --error --skipinstalled --ncpus -4 \
     flowmapper flowmapblue mapgl mapSpain hexSticker duckdb sf remotes \
     httr2 parallelly memuse xml2 here curl quarto spanishoddata \
     scales furrr future future.mirai tidyverse

# set environment
RUN echo 'SPANISH_OD_DATA_DIR=~/mitms' >> ~/.Renviron

EXPOSE 8888



CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser"]
