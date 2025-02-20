# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

FROM condaforge/mambaforge:22.9.0-3

RUN mamba install cartopy pycaret pandas==1.5.3 matplotlib 

