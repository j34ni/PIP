# PIPenv

# Description

This is a definition file to illustrate the use of an Ubuntu22.04 container to create a virtual python environment and install with pip specific packages listed in a `requirements.txt` file located in the same folder as the `Dockerfile`

# Build

**A container image** built with `cftime==1.6.4`, `netCDF4==1.7.1.post1` and `xarray==2024.6.0` was automatically created on `https://quay.io/repository/jeani/pipenv` and **can be pulled and used straight away** (see below).

Those who want to install different packages have to rebuild the container as follows:

* clone this repository `git clone https://quay.io/repository/jeani/pipenv`
* modify the content of the `requirements.txt` file to suit their needs
* build the container with `docker build --progress=plain -t pipenv -f Dockerfile .`
* if needed save the container image `docker save pipenv -o pipenv.tar`
* and convert it to `.sif`: `apptainer build pipenv.sif docker-archive://pipenv.tar`


# Usage

Assuming that your data and scripts are in the directory called `my_data_and_scripts_on_the_host` you have to make it *visible* from inside the container using `-v` (for Docker) or `--bind` (for Singularity/Apptainer) and provide a location not already in use (here I made up something nammed `/opt/uio/my_data_and_scripts_in_the_container`).

## with Docker

Pull the container image with: 

`docker pull quay.io/jeani/pipenv:latest`

execute it with:

`docker run -it --rm -v my_data_and_scripts_on_the_host:/opt/uip/my_data_and_scripts_in_the_container pipenv:latest`

## with Apptainer

Pull the container image with: 

`apptainer pull docker://quay.io/jeani/pipenv:latest`

execute it with:

`apptainer shell --bind my_data_and_scripts_on_the_host:/opt/uio/my_data_and_scripts_in_the_container pipenv_latest.sif`

then, once inside the container activate the environment and perform your data processing as usual:

* `source /opt/uio/my_new_pythonenv/bin/activate`
* change directory to `/opt/uio/my_data_and_scripts_in_the_container` and run for instance `python run_my_script.py`
