# Simple makefile for building and packaging project Armadillo

# default location for building
BUILD_TREE = build
# given by docker -v option
PACKAGE_DIR = /packages/ARMADILLO_3.4.3
# default package name
PACKAGE_NAME = ARMADILLO_3.4.3


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

.PHONY : debug-cmake
debug-cmake:
	mkdir -p $(BUILD_TREE)_debug
	cd $(BUILD_TREE)_debug && cmake -DCMAKE_BUILD_TYPE=Debug ..

.PHONY : debug-build
debug-build: debug-cmake
	cd $(BUILD_TREE)_debug && make armadillo-lib

.PHONY : debug-package
debug-package:
	cd $(BUILD_TREE)_debug && make package	
	# copy out packages
	mkdir -p $(PACKAGE_DIR)_debug
	cp $(BUILD_TREE)_debug/$(PACKAGE_NAME).deb 		$(PACKAGE_DIR)_debug/$(PACKAGE_NAME).deb
	cp $(BUILD_TREE)_debug/$(PACKAGE_NAME).tar.gz 	$(PACKAGE_DIR)_debug/$(PACKAGE_NAME).tar.gz
	cp $(BUILD_TREE)_debug/$(PACKAGE_NAME).zip 		$(PACKAGE_DIR)_debug/$(PACKAGE_NAME).zip

.PHONY : debug-clean
debug-clean:
	rm -rf $(BUILD_TREE)_debug

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

.PHONY : release-cmake
release-cmake:
	mkdir -p $(BUILD_TREE)_release
	cd $(BUILD_TREE)_release && cmake -DCMAKE_BUILD_TYPE=Release ..

.PHONY : release-build
release-build: debug-cmake
	cd $(BUILD_TREE)_release && make armadillo-lib
	bash $(BUILD_TREE)_release/conf.sh

.PHONY : release-package
release-package:
	cd $(BUILD_TREE)_release && make package	
	# copy out packages
	mkdir -p $(PACKAGE_DIR)_release
	cp $(BUILD_TREE)_release/$(PACKAGE_NAME).deb 	$(PACKAGE_DIR)_release/$(PACKAGE_NAME).deb
	cp $(BUILD_TREE)_release/$(PACKAGE_NAME).tar.gz $(PACKAGE_DIR)_release/$(PACKAGE_NAME).tar.gz
	cp $(BUILD_TREE)_release/$(PACKAGE_NAME).zip 	$(PACKAGE_DIR)_release/$(PACKAGE_NAME).zip

.PHONY : release-clean
release-clean:
	rm -rf $(BUILD_TREE)_release

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

.PHONY : clean
clean: debug-clean release-clean