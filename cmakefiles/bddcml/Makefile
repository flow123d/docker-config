# Simple makefile for building and packaging project BDDCML and Blobex


# default build type
BUILD_TYPE = Debug
# default location for building
BUILD_TREE = /usr/lib/bddcml_blopex
# get cwd
SOURCE_TREE = $(shell pwd)
# default package name
PACKAGE_NAME = BDDCML_2.4.0
# given by docker -v option
PACKAGE_DIR = /packages/$(PACKAGE_NAME)_$(BUILD_TYPE)

# use petsc lapack and blas instead of system's
USE_PETSC = Off
# where is petsc installed (only viable if PETSC_DIR is set)
PETSC_DIR  = /usr/lib/petsc
PETSC_ARCH = linux-$(BUILD_TYPE)

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

.PHONY : cmake
cmake:
	mkdir -p $(BUILD_TREE)
	cd $(BUILD_TREE) && cmake -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DUSE_PETSC=$(USE_PETSC) -DPETSC_DIR=$(PETSC_DIR) -DPETSC_ARCH=$(PETSC_ARCH) $(SOURCE_TREE)

.PHONY : build
build: cmake
	 cd $(BUILD_TREE) && make blopex-lib
	 cd $(BUILD_TREE) && make bddcml-lib

.PHONY : package
package: build
	cd $(BUILD_TREE) && make package	
	# copy out packages
	mkdir -p $(PACKAGE_DIR)
	cp $(BUILD_TREE)/$(PACKAGE_NAME).deb     $(PACKAGE_DIR)/$(PACKAGE_NAME).deb
	cp $(BUILD_TREE)/$(PACKAGE_NAME).tar.gz  $(PACKAGE_DIR)/$(PACKAGE_NAME).tar.gz
	cp $(BUILD_TREE)/$(PACKAGE_NAME).zip     $(PACKAGE_DIR)/$(PACKAGE_NAME).zip
	cp $(BUILD_TREE)/_CPack_Packages/Linux/DEB/$(PACKAGE_NAME)/md5sums $(PACKAGE_DIR)/$(PACKAGE_NAME).md5sums


.PHONY : clean
clean:
	rm -rf $(BUILD_TREE)
	rm -rf build_*


.PHONE : help
help:
	@echo "Valid targets for this Makefile:"
	@echo "   cmake   - run cmake in BUILD_TREE dir"
	@echo "   build   - downloads external lib and runs compilation"
	@echo "   package - packs library and copies packages to PACKAGE_DIR"
	@echo "   clean   - deletes BUILD_TREE dir and all build_*"
	@echo "   help    - prints this message"
	@echo ""
	@echo "To change buildy type (default Debug) set variable"
	@echo "   BUILD_TYPE - e.g. make BUILD_TYPE=Release package"
	@echo "To change package copy location (default in /package dir) set variable"
	@echo "   PACKAGE_DIR - e.g. make PACKAGE_DIR=/var/www/html package"
	
	