# Rules to make the docker images and libraries.

images-version=3.1.0

build-base=flow123d/build-base:$(images-version)

# This target only configure the build process.
# Useful for building unit tests without actually build whole program.

build_dir=build
build_libs_dir=$(build_dir)/build_libs

build=docker build --build-arg images_version=$(images-version)
run=docker run -v ${PWD}/$(build_libs_dir):/build_dir/build_libs -w /build_dir/build_libs

$(build_dir):  
	mkdir -p $(build_dir)



.PHONY: img-base
img-base: 
	cd dockerfiles/base && $(build) --tag flow123d/base:$(images-version) .

.PHONY: img-build-base
img-build-base: img-base
	cd dockerfiles/build-base && $(build) --tag $(build-base) .

.PHONY: build-libs
build-libs: build-libs-dbg build-libs-rel
	

.PHONY: $(build_libs_dir)
$(build_libs_dir): $(build_dir)
	cp -Rf build_libs $(build_dir)
	
.PHONY: lib-builddbg-buil
build-libs-dbg: img-build-base $(build_libs_dir)
	$(run) $(build-base) make build_type=Debug all-libs      # build libraries, put packages into build-dir


.PHONY: build-libs-rel
build-libs-rel: img-build-base $(build_libs_dir)
	$(run) $(build-base) make build_type=Release all-libs      # build libraries, put packages into build-dir
