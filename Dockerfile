FROM ubuntu:22.04

# Authors Jean Iaquinta
# Contact jeani@uio.no
# Version v1.0.0
#
# This is a definition file to illustrate the use of an Ubuntu22.04 container to create a virtual python environment 
# and install with pip specific packages listed in a "requirement.txt" file located in the same folder as this Dockerfile
#

# Update system and install basic packages
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3 python-is-python3 python3-venv && \
    rm -rf /var/lib/apt/lists/*

# PIP VENV & packages install
RUN mkdir -p /opt/uio 
COPY requirements.txt /opt/uio/requirements.txt
SHELL ["/bin/bash", "-c"]
RUN python -m venv /opt/uio/my_new_pythonenv && \
    source /opt/uio/my_new_pythonenv/bin/activate && \
    python -m pip install attrs==23.2.0 && \
    python -m pip install -r /opt/uio/requirements.txt && \
    rm /opt/uio/requirements.txt
