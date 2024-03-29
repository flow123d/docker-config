# Rules to make the docker images and libraries.

images_version=$(shell cat images_version)

# This target only configure the build process.
# Useful for building unit tests without actually build whole program.

build_dir=build_$(build_type)


build=docker build --build-arg images_version=$(images_version)
build_gnu=$(build) -f Dockerfile-gnu
build_intel=$(build) -f Dockerfile-intel
run=docker run -v ${PWD}/$(build_dir):/build_dir -w /build_dir
versions=--build-arg ver_yamlcpp=0.6.3 \
	 --build-arg ver_armadillo=10.5.2 \
	 --build-arg ver_mpich=3.4.2 \
	 --build-arg ver_petsc=3.17.0 \
	 --build-arg ver_hypre=2.24.0 \
	 --build-arg ver_bddcml=2.6 \
	 --build-arg ver_permon=3.17.0 

# TODO: write versions available into the image and use autoamticaly in Flow123d configuration

	 
# $(build_dir):  
# 	mkdir -p $(build_dir)


# INTEL IMAGES #


.PHONY: img-base-intel
img-base-intel: dockerfiles/base/Dockerfile-intel dockerfiles/base/entrypoint.sh
	cd dockerfiles/base && $(build_intel) --tag flow123d/base-intel:$(images_version) .

.PHONY: img-base-build-intel
img-base-build-intel: img-base-intel dockerfiles/base-build/Dockerfile-intel
	cd dockerfiles/base-build && $(build_intel) --tag flow123d/base-build-intel:$(images_version) .

libs_dbg:=libs-build-intel-dbg
.PHONY: libs-build-intel-dbg
$(libs_dbg): img-base-build-intel dockerfiles/libs-intel/Dockerfile
	cd dockerfiles/libs-intel && $(build) $(versions) --build-arg BUILD_TYPE=Debug --tag flow123d/$(libs_dbg):$(images_version) .

.PHONY: img-flow-dev-intel-dbg
img-flow-dev-intel-dbg: $(libs_dbg) dockerfiles/flow-dev-intel/Dockerfile
	cd dockerfiles/flow-dev-intel && $(build) $(versions) --build-arg BUILD_TYPE=Debug --build-arg source_image=flow123d/$(libs_dbg):$(images_version) --tag flow123d/flow-dev-intel-dbg:$(images_version) .

libs_rel:=libs-build-intel-rel
.PHONY: $(libs_rel)
$(libs_rel): img-base-build-intel dockerfiles/libs-intel/Dockerfile
	cd dockerfiles/libs-intel && $(build) $(versions) --build-arg BUILD_TYPE=Release --tag flow123d/$(libs_rel):$(images_version) .

.PHONY: img-flow-dev-intel-rel
img-flow-dev-intel-rel: $(libs_rel) dockerfiles/flow-dev-intel/Dockerfile
	cd dockerfiles/flow-dev-intel && $(build) $(versions) --build-arg BUILD_TYPE=Release --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/flow-dev-intel-rel:$(images_version) .

# .PHONY: img-flow-dev-intel-profile
# img-flow-dev-intel-profile: img-flow-dev-intel-rel dockerfiles/flow-dev-intel/Dockerfile
# 	cd dockerfiles/flow-dev-profile && $(build) --build-arg source_image=flow123d/flow-dev-intel-rel:$(images_version) --tag flow123d/flow-dev-intel-profile:$(images_version) .

.PHONY: flow-dev-intel
flow-dev-intel: img-install-intel img-flow-dev-intel-dbg img-flow-dev-intel-rel #img-flow-dev-intel-profile

-PHONY: img-install-intel
img-install-intel: img-base-intel $(libs_rel)
	cd dockerfiles/install-intel && $(build) $(versions) --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/install-intel:$(images_version) .

# GNU IMAGES #

.PHONY: img-base-gnu
img-base-gnu: dockerfiles/base/Dockerfile-gnu dockerfiles/base/entrypoint.sh
	cd dockerfiles/base && $(build_gnu) --tag flow123d/base-gnu:$(images_version) .

.PHONY: img-base-build-gnu
img-base-build-gnu: img-base-gnu dockerfiles/base-build/Dockerfile-gnu
	cd dockerfiles/base-build && $(build_gnu) --tag flow123d/base-build-gnu:$(images_version) .

libs_dbg:=libs-build-gnu-dbg
.PHONY: $(libs_dbg)
$(libs_dbg): img-base-build-gnu dockerfiles/libs-gnu/Dockerfile
	cd dockerfiles/libs-gnu && $(build) $(versions) --build-arg BUILD_TYPE=Debug --tag flow123d/$(libs_dbg):$(images_version) .

.PHONY: img-flow-dev-gnu-dbg
img-flow-dev-gnu-dbg: $(libs_dbg) dockerfiles/flow-dev-gnu/Dockerfile
	cd dockerfiles/flow-dev-gnu && $(build) $(versions) --build-arg BUILD_TYPE=Debug --build-arg source_image=flow123d/$(libs_dbg):$(images_version) --tag flow123d/flow-dev-gnu-dbg:$(images_version) .

libs_rel:=libs-build-gnu-rel
.PHONY: $(libs_rel)
$(libs_rel): img-base-build-gnu dockerfiles/libs-gnu/Dockerfile
	cd dockerfiles/libs-gnu && $(build) $(versions) --build-arg BUILD_TYPE=Release --tag flow123d/$(libs_rel):$(images_version) .

.PHONY: img-flow-dev-gnu-rel
img-flow-dev-gnu-rel: $(libs_rel) dockerfiles/flow-dev-gnu/Dockerfile
	cd dockerfiles/flow-dev-gnu && $(build) $(versions) --build-arg BUILD_TYPE=Release --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/flow-dev-gnu-rel:$(images_version) .

# .PHONY: img-flow-dev-gnu-profile
# img-flow-dev-gnu-profile: img-flow-dev-gnu-rel
# 	cd dockerfiles/flow-dev-profile && $(build) --build-arg source_image=flow123d/flow-dev-gnu-rel:$(images_version) --tag flow123d/flow-dev-gnu-profile:$(images_version) .

	
.PHONY: flow-dev-gnu
flow-dev-gnu: img-install-gnu img-flow-dev-gnu-dbg img-flow-dev-gnu-rel # img-flow-dev-gnu-profile

-PHONY: img-install-gnu
img-install-gnu: img-base-gnu $(libs_rel)
	cd dockerfiles/install-gnu && $(build) $(versions) --build-arg source_image=flow123d/$(libs_rel):$(images_version) --tag flow123d/install-gnu:$(images_version) .


# Push all public images.

.PHONY: push-gnu
push-gnu:
	docker push flow123d/base-gnu:$(images_version)
	docker push flow123d/flow-dev-gnu-dbg:$(images_version)
	docker push flow123d/flow-dev-gnu-rel:$(images_version)
	docker push flow123d/install-gnu:$(images_version)


.PHONY: push-intel
push-intel:
	docker push flow123d/base-intel:$(images_version)
	docker push flow123d/flow-dev-intel-dbg:$(images_version)
	docker push flow123d/flow-dev-intel-rel:$(images_version)
	docker push flow123d/install-intel:$(images_version)

.PHONY: push
push: push-gnu push-intel
	
.PHONY: all
all: flow-dev-gnu img-install-gnu flow-dev-intel img-install-intel  push


# Mark built images as latest.
# Do not use: latest can change, all tools should depend on particular tag that should not change (only fixes allowed).
.PHONY: latest
latest:
	docker tag flow123d/flow-dev-intel-dbg:$(images_version) flow123d/flow-dev-intel-dbg:latest
	docker tag flow123d/flow-dev-intel-rel:$(images_version) flow123d/flow-dev-intel-rel:latest
	docker push flow123d/flow-dev-intel-dbg:latest
	docker push flow123d/flow-dev-intel-rel:latest
	docker tag flow123d/flow-dev-gnu-dbg:$(images_version) flow123d/flow-dev-gnu-dbg:latest
	docker tag flow123d/flow-dev-gnu-rel:$(images_version) flow123d/flow-dev-gnu-rel:latest
	docker push flow123d/flow-dev-gnu-dbg:latest
	docker push flow123d/flow-dev-gnu-rel:latest

	docker tag flow123d/install-gnu:$(images_version) flow123d/install-gnu:latest
	docker push flow123d/install-gnu:latest
	docker tag flow123d/install-intel:$(images_version) flow123d/install-intel:latest
	docker push flow123d/install-intel:latest


.PHONY: clean
clean:
	docker system prune	# remove dangling images (= without name)
