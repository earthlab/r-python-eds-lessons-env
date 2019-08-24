FROM continuumio/miniconda3:4.6.14

ENV PYTHONDONTWRITEBYTECODE=true

RUN conda update conda --yes \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict \
    && conda install --yes \
    python=3.7 \
    r-base=3.5 \
    autopep8 \
    basemap \
    cartopy \
    cenpy \
    climata \
    contextily \
    earthpy \
    elevation \
    folium \
    geocoder \
    geojson \
    geopandas \
    geopy \
    hydrofunctions \
    mapboxgl \
    mapclassify \
    nano \
    nbclean \
    nltk \
    papermill \
    pyproj \
    pyqt \
    pysal \
    r-codetools \
    r-rcolorbrewer \
    r-cowplot \
    r-cyphr \
    r-curl \
    r-devtools \
    r-dplyr \
    r-dygraphs \
    r-ff \
    r-ggmap \
    r-ggplot2 \
    r-ggsn \
    r-gridextra \
    r-knitr \
    r-lemon \
    r-magick \
    r-mapdata \ 
    r-maps \
    r-maptools \
    r-microbenchmark \
    r-plotly \
    r-r.utils \
    r-raster \
    r-rastervis \
    r-rgdal \
    r-rgeos \
    r-rjsonio \
    r-rmarkdown \
    r-rsaga \
    r-rtweet \
    r-sf \
    r-stringr \
    r-widyr \
    r-tm \
    r-igraph \
    r-leaflet \
    r-lubridate \
    r-rcurl \
    r-ggraph \
    r-ggthemes \
    r-gganimate \
    r-readr \
    r-webshot \
    r-zoo \
    rasterio \
    rasterstats \
    richdem \
    scikit-image \
    scikit-learn \
    shapely \
    textblob \
    tweepy \
    && conda clean --all --yes --force-pkgs-dirs \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && conda list

RUN apt-get update \
    && wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.7_all.deb -P ~/Downloads \
    && apt install ~/Downloads/ttf-mscorefonts-installer_3.7_all.deb -y \
    && apt-mark hold ttf-mscorefonts-installer

RUN ln -s /bin/tar /bin/gtar \ 
    && R --silent -e "devtools::install_github('earthlab/qtoolkit', dependencies = FALSE)" 

COPY import_check.py import_check.py
RUN python import_check.py

COPY library_check.R library_check.R
RUN R CMD BATCH library_check.R
