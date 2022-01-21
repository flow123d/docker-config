ARG images_version
ARG base_image
FROM ${base_image} as installer

RUN env MPICC=$(cat /.mpiccpath) python3 -m pip install --no-cache-dir --ignore-installed  mpi4py
