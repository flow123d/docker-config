

CID=flow
FLOW=/opt/flow123d/flow123d
FLOW_MIN=/opt/flow123d
DESTINATION=$(shell pwd)

VERSION=$(strip $(shell docker exec $(CID) cat $(FLOW)/version))
PACK_NAME=Flow123d-$(VERSION)-Linux.tar.gz
IMG_NAME=Flow123d-$(VERSION)-docker-image.tar.gz

LIN_ARCH=Flow123d-$(VERSION)-linux-install.tar.gz
WIN_ARCH=Flow123d-$(VERSION)-windows-install.zip

# create install packages
create-packages: $(DESTINATION)/$(IMG_NAME)
	mkdir -p install-linux
	mkdir -p install-windows
	
	
	cd install-linux && cmake \
		-DIS_WINDOWS=0 \
		-DFLOW_VERSION="$(VERSION)" \
		-DIMAGE_TAG="flow123d/v$(VERSION)" \
		-DIMAGE_NAME="$(IMG_NAME)" \
		-DDEST="$(DESTINATION)" \
		../project
	make -C install-linux package
	mv      install-linux/$(LIN_ARCH) $(DESTINATION)/$(LIN_ARCH)
	
	# rm   -rf install
	# mkdir -p install
	# tar -xzf $(DESTINATION)/$(LIN_ARCH) -C install/ --strip-components=1
	
	cd install-windows && cmake \
		-DIS_WINDOWS=1 \
		-DFLOW_VERSION="$(VERSION)" \
		-DIMAGE_TAG="flow123d/v$(VERSION)" \
		-DIMAGE_NAME="$(IMG_NAME)" \
		-DDEST="$(DESTINATION)" \
		../project
	make -C install-windows package
	mv      install-windows/$(WIN_ARCH) $(DESTINATION)/$(WIN_ARCH)

# clean unwanted files in destination
remove-unwanted:
	rm -rf $(DESTINATION)/$(PACK_NAME)
	rm -rf $(DESTINATION)/tests
	rm -rf $(DESTINATION)/doc

# create install image
$(DESTINATION)/$(IMG_NAME): $(DESTINATION)/$(PACK_NAME)
	-@docker rm -f flow_rel
	docker run -tid --name flow_rel flow123d/install
	docker exec flow_rel mkdir -p $(FLOW)
	
	docker cp   $(DESTINATION)/$(PACK_NAME) \
	            flow_rel:/tmp/$(PACK_NAME)
	
	docker exec flow_rel \
	            tar -xvzf /tmp/$(PACK_NAME) \
	            -C $(FLOW_MIN) --strip-components=1
	
	docker exec   flow_rel rm -rf /tmp/$(PACK_NAME)
	docker export flow_rel > $(DESTINATION)/$(IMG_NAME)
	docker rm     -f flow_rel
	
	
# create flow123d package
$(DESTINATION)/$(PACK_NAME): $(DESTINATION)/tests
	docker exec $(CID) make -C $(FLOW) package
	docker cp $(CID):$(FLOW)/build_tree/$(PACK_NAME) $(DESTINATION)/$(PACK_NAME)


# copy tests and docs
$(DESTINATION)/tests:
	# create destination folders
	mkdir -p $(DESTINATION)/doc/htmldoc
	mkdir -p $(DESTINATION)/tests
	
	docker cp $(CID):$(FLOW)/build_tree/doc/reference_manual/flow123d_doc.pdf $(DESTINATION)/doc/flow123d_doc.pdf
	docker cp $(CID):$(FLOW)/build_tree/htmldoc/html/src/. $(DESTINATION)/doc/htmldoc
	docker cp $(CID):$(FLOW)/tests/. $(DESTINATION)/tests
	
	# delete runtest because we will have to create other runtest for docker
	rm -rf    $(DESTINATION)/tests/runtest


# PACKAGE_PATH=$(DESTINATION)/$(PACKAGE_NAME)
# 
# DOCKER_NAME=DockerToolbox-1.12.2.exe
# DOCKER_PATH=$(DESTINATION)/$(DOCKER_NAME)
# 
# INSTALLER_NAME=Flow123d-docker-windows.zip
# INSTALLER_PATH=$(DESTINATION)/$(INSTALLER_NAME)
# 
# IMAGE_NAME=Flow123d-image.tar.gz
# IMAGE_PATH=$(DESTINATION)/$(IMAGE_NAME)
# 
# MOUNT=-v $(shell pwd)/build:/opt/flow123d/
# MOUNT=""
# 
# DOCKER_IMAGE_NAME=flow123d/v200
# 
# 
# # target will create docker image with flow123d installed
# create-install-image: $(PACKAGE_PATH)
# 	-@docker rm -f flow_rel
# 	docker run -tid --name flow_rel flow123d/install
# 	docker exec flow_rel mkdir -p $(FLOW)
# 	docker cp  $(PACKAGE_PATH) \
# 	            flow_rel:/tmp/$(PACKAGE_NAME)
# 	docker exec flow_rel \
# 	            tar -xvzf /tmp/Flow123d-2.0.0-Linux.tar.gz \
# 	            -C $(FLOW) --strip-components=1
# 	docker exec flow_rel rm -rf /tmp/Flow123d-2.0.0-Linux.tar.gz
# 	docker export flow_rel > $(IMAGE_PATH)
# 	docker stop flow_rel
# 	docker rm   -f flow_rel
# 
# # target will create windows installer (zip file for now)
# # containing flow123d docker image and DockerToolbox
# create-windows-installer: $(IMAGE_PATH)
# 	-@docker rm -f nsis
# 	docker run -tid --name nsis flow123d/nsis
# 	docker exec nsis mkdir -p /pack/build/libs/
# 	docker        cp $(IMAGE_PATH)  nsis:/pack/libs/
# 	-docker       cp $(DOCKER_PATH) nsis:/pack/libs/
# 	docker exec nsis make IMAGE_NAME=$(DOCKER_IMAGE_NAME) all
# 	docker cp   nsis:/pack/build/Flow123d-0.1.1-Linux.zip $(DESTINATION)
# 	docker stop nsis
# 	docker rm   -f nsis
# 	mv     $(DESTINATION)/Flow123d-0.1.1-Linux.zip $(INSTALLER_PATH)
# 
# 
# # target will run fresh installation of flow123d
# # and will pack this flow
# package-flow123d:
# 	-@docker rm -f flow_build
# 	docker run -tid --name flow_build $(MOUNT) flow123d/flow-libs-dev-dbg
# 	docker exec flow_build git clone \
# 	            https://github.com/jbrezmorf/flow123d.git $(FLOW)
# 	docker exec flow_build cp \
# 	            $(FLOW)/config/config-jenkins-docker-debug.cmake \
# 	            $(FLOW)/config.cmake
# 	docker exec flow_build make -C $(FLOW) -j4 package
# 	docker cp   flow_build:$(FLOW)/build_tree/$(PACKAGE_NAME) \
# 	            $(PACKAGE_PATH)
# 	docker stop flow_build
# 	docker rm   -f flow_build