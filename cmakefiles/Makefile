# This Makefile serves for building and publish libraries within a docker container
# using image flow123d/base-env (by default)


# Following targets are called by the Jenkins
# By default image flow123d/base-env image is used to build all the libraries
# This Makefile is configurable however is intended to use via Jenkins


# All the makefiles in subfolders have some common options, namely:
#    install_prefix   - installation prefix, which is by default the same for all Libs
#    prefix           - location where lib will be installed = <install-prefix>/<lib_name>
#    build_type       - Either Debug or Release, value is passed to the CMakeLists.txt
#    build_dir        - location of the compilation, by default ./build-<build_type>

#    ... there are other options but I would avoid changing their default value, 
#    it is not guaranteed to work (such as version, which can affect what version)
#    will be downloaded and installed, but given version may not be present on the server
# subfolder makefiles configurable options are lower case, whereas this makefile
# uses upper case variable to configure to differentiate


# Showing all this together using yamlcpp as example
# `make yamlcpp` will:
#    download and commpile yamlcpp in $(build_dir) folder:
#         ./cmakefiles/yamlcpp/build-Debug
#    install yamlcpp to the $(prefix) location:
#         /usr/local/yamlcpp-0.5.2


# to tune the installation process of libraries, use makefiles in the subfolders
#  (this can be usefull for installing libraries on HPC clusters)
# such as:
#    cd petsc
#    module load gcc/6.3.0
#    make \
#        install_prefix=/storage/praha1/home/flow123d-libs \
#        configure_opts=--with-mpi-dir=/path/to/mpi \
#        build


INSTALL_PREFIX=/usr/local
LIBRARY=$(@)
BUILD_TYPE=Debug
PACKAGE_DIR_REMOTE=/var/www/html/static/packages
DEB_ROOT=http://ciflow.nti.tul.cz/static/packages

DID=lib-$(LIBRARY)
IMAGE=flow123d/base-env

URL=
DEB_NAME=$(notdir $(URL))

LIB_MPICH=3.2.0
LIB_YAMLCPP=0.5.2
LIB_PETSC=3.8.3
LIB_ARMADILLO=8.3.4
LIB_BDDCML=2.5.0


.PHONY : publish
publish:
	@/bin/echo -e "\n=== Publishing image $(DID) ===\n"
	-docker exec $(DID) chown -R $(shell id -u) /tmp/work
	docker rm -f $(DID)
	scp -r $(CURDIR)/$(LIBRARY)/packages/* builder@ciflow.nti.tul.cz:$(PACKAGE_DIR_REMOTE)/

.PHONY : start-image
start-image:
	@/bin/echo -e "\n=== Starting image $(IMAGE) ===\n"
	-@docker rm -f $(DID) 2>/dev/null
	docker pull $(IMAGE)
	docker run -di --name=$(DID) \
			--volume=$(CURDIR):/tmp/work \
			$(IMAGE)

.PHONY : install-lib
install-lib:
	@/bin/echo -e "\n=== Installing $(DEB_NAME) into $(DID) ===\n"
	-docker exec $(DID) wget -qO /tmp/$(DEB_NAME) $(URL)
	-docker exec $(DID) dpkg -i /tmp/$(DEB_NAME)
	-docker exec $(DID) rm -rf /tmp/$(DEB_NAME)

.PHONY : mpich
mpich:
	$(MAKE) LIBRARY=$(LIBRARY) CURDIR=$(CURDIR) IMAGE=$(IMAGE) start-image
	-docker exec $(DID) make -C /tmp/work/$(@) build_type=$(BUILD_TYPE) INSTALL_PREFIX=$(INSTALL_PREFIX) package
	$(MAKE) LIBRARY=$(LIBRARY) PACKAGE_DIR_REMOTE=$(PACKAGE_DIR_REMOTE) publish

.PHONY : petsc armadillo yamlcpp
petsc armadillo yamlcpp:
	$(MAKE) LIBRARY=$(LIBRARY) CURDIR=$(CURDIR) IMAGE=$(IMAGE) start-image
	$(MAKE) LIBRARY=$(LIBRARY) URL=$(DEB_ROOT)/mpich_$(LIB_MPICH)_$(BUILD_TYPE)/mpich-$(LIB_MPICH).deb install-lib
	-docker exec $(DID) /bin/bash -c \
			"PATH=/usr/local/mpich-$(LIB_MPICH)/bin:\$$PATH make -C /tmp/work/$(@) install_prefix=$(INSTALL_PREFIX) build_type=$(BUILD_TYPE) package"
	$(MAKE) LIBRARY=$(LIBRARY) PACKAGE_DIR_REMOTE=$(PACKAGE_DIR_REMOTE) publish

.PHONY : bddcml
bddcml:
	$(MAKE) LIBRARY=$(LIBRARY) CURDIR=$(CURDIR) IMAGE=$(IMAGE) start-image
	$(MAKE) LIBRARY=$(LIBRARY) URL=$(DEB_ROOT)/mpich_$(LIB_MPICH)_$(BUILD_TYPE)/mpich-$(LIB_MPICH).deb install-lib
	$(MAKE) LIBRARY=$(LIBRARY) URL=$(DEB_ROOT)/petsc_$(LIB_PETSC)_$(BUILD_TYPE)/petsc-$(LIB_PETSC).deb install-lib
	-docker exec $(DID) /bin/bash -c \
			"PATH=/usr/local/mpich-$(LIB_MPICH)/bin:\$$PATH make -C /tmp/work/$(@) build_type=$(BUILD_TYPE) install_prefix=$(INSTALL_PREFIX) package"
	$(MAKE) LIBRARY=$(LIBRARY) PACKAGE_DIR_REMOTE=$(PACKAGE_DIR_REMOTE) publish
	


# Following targets are for the debug only and may require sudo
# Prerequisite for the target to work is to have libraries in the /usr/local/<libname>-<version> folder

mpich-no-docker:
	$(MAKE) -C mpich build_type=$(BUILD_TYPE) install_prefix=$(INSTALL_PREFIX) package

armadillo-no-docker:
	$(MAKE) -C armadillo build_type=$(BUILD_TYPE) install_prefix=$(INSTALL_PREFIX) package

petsc-no-docker:
	$(MAKE) -C petsc build_type=$(BUILD_TYPE) install_prefix=$(INSTALL_PREFIX) package

yamlcpp-no-docker:
	$(MAKE) -C yamlcpp build_type=$(BUILD_TYPE) install_prefix=$(INSTALL_PREFIX) package

bddcml-no-docker:
	$(MAKE) -C petsc build_type=$(BUILD_TYPE) install_prefix=$(INSTALL_PREFIX) package
