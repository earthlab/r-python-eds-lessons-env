FROM continuumio/miniconda3:4.6.14

# We can simplify this later by using conda's R.
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    libcurl4-openssl-dev  \
    libgeos-dev  \
    libgdal-dev  \
    libproj-dev \
    libssl-dev  \
    libudunits2-dev  \
    r-base-core \
    nano

COPY setup-r-envt.R setup-r-envt.R

RUN Rscript setup-r-envt.R

COPY environment.yml environment.yml
RUN conda config --add channels conda-forge \
    && conda config --set channel_priority strict \
    && conda update --all --yes \
    && conda env update -n base -f environment.yml \
    && conda clean --all --yes --force-pkgs-dirs

RUN conda list

COPY import_check.py import_check.py

RUN python import_check.py
