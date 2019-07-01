FROM continuumio/miniconda3:4.6.14

ENV PYTHONDONTWRITEBYTECODE=true

RUN conda update conda --yes \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict \
    && conda install --yes --freeze-installed \
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
    nano \
    nbclean \
    nltk \
    papermill \
    pyproj \
    pyqt \
    pysal \
    r-codetools \
    r-dplyr \
    r-ff \
    r-ggmap \
    r-ggplot2 \
    r-gridextra \
    r-knitr \
    r-maps \
    r-microbenchmark \
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
    rasterio \
    rasterstats \
    richdem \
    scikit-image \
    scikit-learn \
    shapely \
    tweepy \
    && conda clean --all --yes --force-pkgs-dirs \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && conda list

COPY import_check.py import_check.py
RUN python import_check.py

COPY library_check.R library_check.R
RUN R CMD BATCH library_check.R
