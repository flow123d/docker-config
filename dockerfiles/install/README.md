# Layers ![info](https://img.shields.io/badge/flow123d/install-549.9 MB-blue.svg)
| Layer | Command                                     |  Size (MB)  | Duration (s) |
|-------|---------------------------------------------|-------------|--------------|
|   1   |`FROM flow123d/base                         `|     0.00    |     2.14     |
|   2   |`MAINTAINER Jan Hybs                        `|     0.00    |     0.04     |
|   3   |`RUN sudo apt-get update && sudo apt-get in `|   322.40    |    228.83    |
|   4   |`RUN sudo pip3 install pyyaml markdown psut `|     6.77    |    14.63     |
|   5   |`RUN sudo apt-get update && sudo apt-get in `|    10.19    |    14.62     |
# Details
 - **Layer 1:**
   
    ```dockerfile
FROM flow123d/base
```

 - **Layer 2:**
   
    ```dockerfile
MAINTAINER Jan Hybs
```

 - **Layer 3:**
   
    ```dockerfile
RUN sudo apt-get update && sudo apt-get install -y  \
    perl \
    python3-pip \
    python3-dev \
    libgfortran3 \
    libblas3 \
    liblapack3 \
    libopenmpi1.10 \
    libhwloc5 \
    openmpi*
```

 - **Layer 4:**
   
    ```dockerfile
RUN sudo pip3 install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo
```

 - **Layer 5:**
   
    ```dockerfile
RUN sudo apt-get update && sudo apt-get install -y  \
    lib32z1
```

