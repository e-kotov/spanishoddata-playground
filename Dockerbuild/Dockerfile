FROM rocker/binder:4.4.1

RUN install2.r --error --skipinstalled --ncpus -4 flowmapper flowmapblue mapgl mapSpain hexSticker duckdb sf remotes httr2 parallelly memuse xml2 here curl quarto

RUN R -e "install.packages('spanishoddata', repos = c('https://ropenspain.r-universe.dev', 'https://packagemanager.posit.co/cran/__linux__/jammy/2024-11-13'))"

RUN echo 'SPANISH_OD_DATA_DIR=~/spanish_od_data' >> ~/.Renviron

EXPOSE 8888

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser"]
