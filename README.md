[![](https://images.microbadger.com/badges/image/earthlab/r-python-eds-lessons-env.svg)](https://microbadger.com/images/earthlab/r-python-eds-lessons-env "build specs for the eds-lessons environment")
[![](https://images.microbadger.com/badges/version/earthlab/r-python-eds-lessons-env.svg)](https://microbadger.com/images/earthlab/r-python-eds-lessons-env "Version")


# r-python-eds-lessons

Docker container with [Miniforge 3](https://github.com/conda-forge/miniforge) and `R` that builds lessons for the [Earth Data Science learning portal](https://www.earthdatascience.org).

Available packages can be [viewed in the environment.yml file](https://github.com/earthlab/r-python-eds-lessons/environment.yml).

# How to Update the Environment

Notes:
* instead of using the miniconda it uses the miniforge one that is smaller 182.24.37 MB to 100.92 MB, it is configured to conda-forge packages
* packages are stored in the EDS environment.
* there are two files with packages, the environment.yml, which is just a normal env file, and the conda-linux-64.lock. The lock file will, hopefully, solve dependency resolution problems.
* The lockfile is created with `conda-lock -f environment.yml -p linux-64`. So now, instead of updating the packages with every new build of your image, they'll only update when you run that command and update the lock file locally. This will make it easier to track what changed and where the problems are. This dual file config is also nice b/c you have the high level "user" env file and the low level "machine" file.

Also, as a side effect, the solve is run only once when creating the lock file locally, drastically cutting the time it takes to build the image.

## How to Update

1. Install conda-lock if you don't already have it: `conda install -c conda-forge conda-lock`
2. Update the environment file with the new packages of your choice
3. run `conda-lock -f environment.yml -p linux-64` in bash to update the lock  file
4. open a new PR with  this new files (lock file and environment.yml file)

# How to use the docker container

To run this container in an interactive session:

```
docker run -it earthlab/r-python-eds-lessons-env
```

# Contributors

- Leah A. Wasser
- Filipe Pires Alvarenga Fernandes
- Joseph Tuccillo
- Gina L. Li
- Max Joseph
