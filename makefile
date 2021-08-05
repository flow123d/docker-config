# Rules to make the docker images and libraries.

images_version=3.1.0

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

libs_dbg=libs-build-dbg
.PHONY: $(libs_dbg)
$(libs_dbg): img-build-base
	cd dockerfiles/flow-libs && $(build) --build-arg BUILD_TYPE=Debug --tag flow123d/$(libs_dbg):$(images_version) .

.PHONY: img-flow-libs-dev-dbg
img-flow-libs-dev-dbg: $(libs_dbg)
	cd dockerfiles/flow-libs-dev && $(build) --build-arg BUILD_TYPE=Debug --build-arg source_image=flow123d/$(libs_dbg):$(images_version) --tag flow123d/flow-libs-dev-dbg:$(images_version) .

	
libs_rel=libs-build-rel
.PHONY: $(libs_rel)
$(libs_rel): img-build-base
	cd dockerfiles/flow-libs && $(build) --build-arg BUILD_TYPE=Release --tag flow123d/$(libs_rel):$(images_version) .

.PHONY: img-flow-libs-dev-rel
img-flow-libs-dev-rel: $(libs_rel)
	cd dockerfiles/flow-libs-dev && $(build) --build-arg BUILD_TYPE=Release --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/flow-libs-dev-rel:$(images_version) .

.PHONY: flow-libs-dev
flow-libs-dev: img-flow-libs-dev-dbg img-flow-libs-dev-rel

-PHONY: img-install-base
img-install-base: img-base $(libs_rel)
	cd dockerfiles/install-base && $(build) --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/install:$(images_version) .

# Push all public images.
.PHONY: push
push:
	docker push flow123d/flow-libs-dev-dbg:$(images_version)
	docker push flow123d/flow-libs-dev-rel:$(images_version)
	docker push flow123d/install:$(images_version)

.PHONY: all
all: flow-libs-dev img-install-base push
	

# Mark built images as latest.
# Do not use: latest can change, all tools should depend on particular tag that should not change (only fixes allowed).
.PHONY: latest
latest:
	docker tag flow123d/flow-libs-dev-dbg:$(images_version) flow123d/flow-libs-dev-dbg:latest
	docker tag flow123d/flow-libs-dev-rel:$(images_version) flow123d/flow-libs-dev-rel:latest
	docker push flow123d/flow-libs-dev-dbg:latest
	docker push flow123d/flow-libs-dev-rel:latest

	
.PHONY: clean
clean:
	docker system prune	# remove dangling images (= without name)


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
