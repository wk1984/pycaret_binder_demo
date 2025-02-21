# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends wget make m4 patch build-essential ca-certificates cmake curl nano git \
#     && apt-get install -y --no-install-recommends libgeos-dev libproj-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# RUN python3 -V

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py311_25.1.1-2-Linux-x86_64.sh -O ~/miniforge.sh \
# RUN wget --quiet https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py311_25.1.1-1-Linux-x86_64.sh -O ~/miniforge.sh \
    && /bin/bash ~/miniforge.sh -b -p /opt/miniforge \
    && rm ~/miniforge.sh \
    && ln -s /opt/miniforge/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/miniforge/etc/profile.d/conda.sh" >> ~/.bashrc

ENV PATH /opt/miniforge/bin:${PATH}
ARG PATH /opt/miniforge/bin:${PATH}
ENV HDF5_DIR /opt/miniforge/
ENV NETCDF4_DIR /opt/miniforge/ 
ENV SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL True

RUN . /root/.bashrc \
    && /opt/miniforge/bin/conda init bash \
    && conda info --envs \
#    && conda config --set custom_channels.conda-forge https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/ \
    && conda install -c conda-forge mamba -y

RUN . /root/.bashrc \
    && mamba install -c conda-forge jupyterlab jupyter notebook cartopy numpy pandas==1.5.3 scipy shap matplotlib xarray seaborn rioxarray pycaret mlflow==2.16.0 -y