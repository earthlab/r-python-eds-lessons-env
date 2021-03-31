FROM condaforge/miniforge3:4.9.2-7

COPY conda-linux-64.lock conda-linux-64.lock

ENV PYTHONDONTWRITEBYTECODE=true

RUN conda update --yes conda \
    && conda create --name EDS --file conda-linux-64.lock \
    && conda clean --all --yes --force-pkgs-dirs \
    && find ${CONDA_DIR} -follow -type f -name '*.a' -delete \
    && find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete \
    && find ${CONDA_DIR} -follow -type f -name '*.js.map' -delete

RUN echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate EDS" >> /etc/skel/.bashrc
RUN echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate EDS" >> ~/.bashrc

RUN apt-get update \
    && wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.7_all.deb -P ~/Downloads \
    && apt install ~/Downloads/ttf-mscorefonts-installer_3.7_all.deb -y \
    && apt-mark hold ttf-mscorefonts-installer \
    && apt install -y openssh-client git

RUN ln -s /bin/tar /bin/gtar \
    && ${CONDA_DIR}/envs/EDS/bin/R --silent -e "devtools::install_github('earthlab/qtoolkit', dependencies = FALSE)"

COPY import_check.py import_check.py
RUN ${CONDA_DIR}/envs/EDS/bin/python import_check.py

COPY library_check.R library_check.R
RUN ${CONDA_DIR}/envs/EDS/bin/R CMD BATCH library_check.R
