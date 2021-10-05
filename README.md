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

1. Install `conda-lock` if you don't already have it installed: `conda install -c conda-forge conda-lock`
2. Update the `environment.yml` file with the new packages of your choice. NOTE you can also chose to upgrade packages by forcing an install of version x.x or greater. The syntax in the yaml file would look like this if you wanted to ensure that you had the newest version of earthpy:

`- earthpy >= 0.9.4`

3. **Update the conda-lock  file:** Run `conda-lock -f environment.yml -p linux-64` in bash to update the lock  file

### Test the Docker Build Locally
Before opening up a Pull Request on GitHub you may want to test the docker build locally.
To do this:

1. make sure docker is installed on your computer and that you are logged into your account
2. `$ cd` to the root directory of this repo (you should be there already).
3. Run: `docker build -t eds .` This command will build the image locally. The image can be called using the tag "eds". If you want to both build and run the image locally you can use:

`docker build -t eds . && docker run -it eds`

* Note that you can use whatever tag name you wish. Above **eds** is used. Feel
free to substitute any other tag name that works for you.
* Also note that linux users may need to use `sudo` when running docker commands

Once the image builds successfully locally, you are ready to open a pull request
on GitHub.
4. **Open a new pull request on GitHub** with the updated `environment.yml` and `conda-lock` files.

## Notes on Updating this Environment
This environment mixes r and python package to support our build. Because of the
number of packages, sometimes you can get conflicts when you build it. Because
of that it's generally a good idea to begin any updates that you need to
support lessons as soon as you can. If there are conflicts that don't seem to
be easily resolved, the  next step is to go to the **conda-forge** organization
on GitHub and post an issues in the feedstock for the package that is throwing
errors. You can link to the broken build on GitHub for the maintainers to see
what is causing the issue.  

# How to use the docker container by Pulling from DockerHub

To run this container in an interactive session using a built version on dockerhub:

```
$ docker run -it earthlab/r-python-eds-lessons-env
```

# Contributors

- Leah A. Wasser
- Filipe Pires Alvarenga Fernandes
- Nathan Korinek
- Joseph Tuccillo
- Gina L. Li
- Max Joseph
