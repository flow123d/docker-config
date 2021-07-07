# Rules to make the docker images and libraries.

images_version=3.1.1

# This target only configure the build process.
# Useful for building unit tests without actually build whole program.

build_dir=build_$(build_type)


build=docker build --build-arg images_version=$(images_version)
run=docker run -v ${PWD}/$(build_dir):/build_dir -w /build_dir

# $(build_dir):  
# 	mkdir -p $(build_dir)



.PHONY: img-base
img-base: 
	cd dockerfiles/base && $(build) --tag flow123d/base:$(images_version) .

.PHONY: img-build-base
img-build-base: img-base
	cd dockerfiles/build-base && $(build) --tag flow123d/build-base:$(images_version) .

.PHONY: img-libs-build-dbg
img-libs-build-dbg: img-build-base
	cd dockerfiles/flow-libs && $(build) --build-arg BUILD_TYPE=Debug --tag flow123d/libs-build-debug .

.PHONY: img-flow-libs-dev-dbg
img-flow-libs-dev-dbg: img-libs-build-dbg
	cd dockerfiles/flow-libs-dev && $(build) --build-arg BUILD_TYPE=Debug --tag flow123d/flow-libs-dev-dbg:$(images_version) .

#.PHONY: img-flow-libs-dev-rel
#img-flow-libs-dev-dbg: img-libs-build-dbg
#	cd dockerfiles/flow-libs-dev && $(build) --build-arg BUILD_TYPE=debug --tag flow123d/flow-libs-dev-dbg:$(images_version) .

# .PHONY: build-libs-dbg
# build-libs-dbg: img-build-base
# 	$(eval build_type := Debug)
# 	mkdir -p $(build_dir)
# 	cp -r --update build_libs/* $(build_dir)
# 	$(run) $(build-base) make build_type=$(build_type) all-libs      # build libraries, put packages into build-dir

	


# .PHONY: build-libs-rel
# build-libs-rel: img-build-base $(build_libs_dir)
# 	$(run) $(build-base) make build_type=Release all-libs      # build libraries, put packages into build-dir

# img-flow-libs-dev-rel:
