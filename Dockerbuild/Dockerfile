FROM ghcr.io/rocker-org/binder:4.4.2

# become root so apt-get works
USER root

# Remove the problematic r2u repository if it exists to prevent apt-get update failures
RUN rm -f /etc/apt/sources.list.d/r2u.list || true

# install system tools
RUN apt-get update \
 && apt-get install -y --no-install-recommends software-properties-common \
 && add-apt-repository universe \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      gh git htop mc micro nano \
      libxml2-dev libssl-dev libcurl4-openssl-dev libudunits2-dev \
      libgdal-dev libproj-dev libsqlite3-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install R packages from Posit Package Manager binaries
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/noble/latest')); update.packages(ask = FALSE, checkBuilt = TRUE); install.packages(c('flowmapper', 'flowmapblue', 'mapgl', 'mapSpain', 'hexSticker', 'duckdb', 'sf', 'remotes', 'httr2', 'parallelly', 'memuse', 'xml2', 'here', 'curl', 'quarto', 'spanishoddata', 'scales', 'furrr', 'future', 'future.mirai', 'tidyverse'))"

# drop back to notebook user (optional but recommended)
USER $NB_USER

# set environment
RUN echo 'SPANISH_OD_DATA_DIR=~/mitms' >> ~/.Renviron

EXPOSE 8888



CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser"]
