# Rules to make the docker images and libraries.

images_version=3.1.0

# This target only configure the build process.
# Useful for building unit tests without actually build whole program.

build_dir=build_$(build_type)


build=docker build --build-arg images_version=$(images_version)
run=docker run -v ${PWD}/$(build_dir):/build_dir -w /build_dir

# $(build_dir):  
# 	mkdir -p $(build_dir)


.PHONY: img-base-intel
img-base-intel:
	cd dockerfiles/base-intel && $(build) --tag flow123d/base-intel:$(images_version) .

.PHONY: img-base-build-intel
img-base-build-intel: img-base-intel
	cd dockerfiles/base-build-intel && $(build) --tag flow123d/base-build-intel:$(images_version) .

libs_dbg=libs-build-intel-dbg
.PHONY: $(libs_dbg)
$(libs_dbg): img-base-build-intel
	cd dockerfiles/libs-intel && $(build) --build-arg BUILD_TYPE=Debug --tag flow123d/$(libs_dbg):$(images_version) .

.PHONY: img-flow-dev-intel-dbg
img-flow-dev-intel-dbg: $(libs_dbg)
	cd dockerfiles/flow-dev-intel && $(build) --build-arg BUILD_TYPE=Debug --build-arg source_image=flow123d/$(libs_dbg):$(images_version) --tag flow123d/flow-dev-intel-dbg:$(images_version) .

libs_rel=libs-build-intel-rel
.PHONY: $(libs_rel)
$(libs_rel): img-base-build-intel
	cd dockerfiles/libs-intel && $(build) --build-arg BUILD_TYPE=Release --tag flow123d/$(libs_rel):$(images_version) .

.PHONY: img-flow-dev-intel-rel
img-flow-dev-intel-rel: $(libs_rel)
	cd dockerfiles/flow-dev-intel && $(build) --build-arg BUILD_TYPE=Release --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/flow-dev-intel-rel:$(images_version) .

.PHONY: flow-dev-intel
flow-dev-intel: img-flow-dev-intel-dbg img-flow-dev-intel-rel

-PHONY: img-install-intel
img-install-intel: img-base-intel $(libs_rel)
	cd dockerfiles/install-intel && $(build) --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/install-intel:$(images_version) .

# Push all public images.
.PHONY: push
push:
	docker push flow123d/flow-dev-intel-dbg:$(images_version)
	docker push flow123d/flow-dev-intel-rel:$(images_version)
	docker push flow123d/install-intel:$(images_version)

.PHONY: all
all: flow-dev-intel img-install-intel push
	

# Mark built images as latest.
# Do not use: latest can change, all tools should depend on particular tag that should not change (only fixes allowed).
.PHONY: latest
latest:
	docker tag flow123d/flow-dev-intel-dbg:$(images_version) flow123d/flow-dev-intel-dbg:latest
	docker tag flow123d/flow-dev-intel-rel:$(images_version) flow123d/flow-dev-intel-rel:latest
	docker push flow123d/flow-dev-intel-dbg:latest
	docker push flow123d/flow-dev-intel-rel:latest

	
.PHONY: clean
clean:
	docker system prune	# remov dangling images (= without name)


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
