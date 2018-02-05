# Simple makefile for building and packaging project Armadillo

library       = armadillo
version       = 8.3.4
package_name  = $(library)-$(version)

build_type    = Debug
build_dir     = $(CURDIR)/build-$(build_type)
package_dir   = $(CURDIR)/packages/$(library)_$(version)_$(build_type)
cmake         = cmake
clear         = false

install_prefix = /usr/local
prefix         = $(install_prefix)/$(package_name)

# use petsc lapack and blas instead of system's
USE_PETSC = Off
# where is petsc installed (only viable if PETSC_DIR is set)
PETSC_DIR  =
PETSC_ARCH =


.PHONY : configure
configure:
	@if [ "$(clear)" = "true" ]; then\
			rm -rf $(build_dir);\
	fi
	mkdir -p $(build_dir)
	cd $(build_dir) && $(cmake) \
				-DCMAKE_BUILD_TYPE=$(build_type) \
				-DCMAKE_INSTALL_PREFIX=$(prefix) \
				-DLIBRARY_VERSION=$(version) \
				-DLIBRARY_NAME=$(library) \
				-DUSE_PETSC=$(USE_PETSC) \
				-DPETSC_DIR=$(PETSC_DIR) \
				-DPETSC_ARCH=$(PETSC_ARCH) \
				$(CURDIR)

.PHONY : build
build: configure
	cd $(build_dir) && make external-lib

package: build
	cd $(build_dir) && make package

	mkdir -p $(package_dir)
	cp $(build_dir)/$(package_name).deb     $(package_dir)/$(package_name).deb
	cp $(build_dir)/$(package_name).tar.gz  $(package_dir)/$(package_name).tar.gz
	cp $(build_dir)/$(package_name).zip     $(package_dir)/$(package_name).zip
	cp $(build_dir)/_CPack_Packages/Linux/DEB/$(package_name)/md5sums $(package_dir)/$(package_name).md5sums


.PHONY : clean
clean:
	rm -rf $(build_dir)
	rm -rf $(prefix)
	rm -rf $(package_dir)/$(package_name)*

.PHONE : help
help:
	@echo "Valid targets for this Makefile: "
	@echo "   configure - run cmake in BUILD_TREE dir"
	@echo "   build     - downloads external lib and runs compilation"
	@echo "   package   - packs library and copies packages to package_dir"
	@echo "   clean     - deletes build_dir dir and all build_*"
	@echo "   help      - prints this message"
	@echo ""
	@echo "To change buildy type (default Debug) set variable"
	@echo "   build_type - e.g. make build_type=Release package (default is $(build_type))"
	@echo "To change package copy location (default is $(package_dir)) set variable"
	@echo "   package_dir - e.g. make package_dir=/var/www/html package"
