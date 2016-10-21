
DESTINATION=$(shell pwd)
FLOW=/opt/flow123d/flow123d

PACKAGE_NAME=Flow123d-2.0.0-Linux.tar.gz
PACKAGE_PATH=$(DESTINATION)/$(PACKAGE_NAME)

DOCKER_NAME=DockerToolbox-1.12.2.exe
DOCKER_PATH=$(DESTINATION)/$(DOCKER_NAME)

INSTALLER_NAME=Flow123d-docker-windows.zip
INSTALLER_PATH=$(DESTINATION)/$(INSTALLER_NAME)

IMAGE_NAME=Flow123d-image.tar.gz
IMAGE_PATH=$(DESTINATION)/$(IMAGE_NAME)

MOUNT=-v $(shell pwd)/build:/opt/flow123d/
MOUNT=""

DOCKER_IMAGE_NAME=flow123d/v200


# target will create docker image with flow123d installed
create-install-image: $(PACKAGE_PATH)
	-@docker rm -f flow_rel
	docker run -tid --name flow_rel flow123d/install
	docker exec flow_rel mkdir -p $(FLOW)
	docker cp  $(PACKAGE_PATH) \
	            flow_rel:/tmp/$(PACKAGE_NAME)
	docker exec flow_rel \
	            tar -xvzf /tmp/Flow123d-2.0.0-Linux.tar.gz \
	            -C $(FLOW) --strip-components=1
	docker exec flow_rel rm -rf /tmp/Flow123d-2.0.0-Linux.tar.gz
	docker export flow_rel > $(IMAGE_PATH)
	docker stop flow_rel
	docker rm   -f flow_rel

# target will create windows installer (zip file for now)
# containing flow123d docker image and DockerToolbox
create-windows-installer: $(IMAGE_PATH)
	-@docker rm -f nsis
	docker run -tid --name nsis flow123d/nsis
	docker exec nsis mkdir -p /pack/build/libs/
	docker        cp $(IMAGE_PATH)  nsis:/pack/libs/
	-docker       cp $(DOCKER_PATH) nsis:/pack/libs/
	docker exec nsis make IMAGE_NAME=$(DOCKER_IMAGE_NAME) all
	docker cp   nsis:/pack/build/Flow123d-0.1.1-Linux.zip $(DESTINATION)
	docker stop nsis
	docker rm   -f nsis
	mv     $(DESTINATION)/Flow123d-0.1.1-Linux.zip $(INSTALLER_PATH)


# target will run fresh installation of flow123d
# and will pack this flow
package-flow123d:
	-@docker rm -f flow_build
	docker run -tid --name flow_build $(MOUNT) flow123d/flow-libs-dev-dbg
	docker exec flow_build git clone \
	            https://github.com/jbrezmorf/flow123d.git $(FLOW)
	docker exec flow_build cp \
	            $(FLOW)/config/config-jenkins-docker-debug.cmake \
	            $(FLOW)/config.cmake
	docker exec flow_build make -C $(FLOW) -j4 package
	docker cp   flow_build:$(FLOW)/build_tree/$(PACKAGE_NAME) \
	            $(PACKAGE_PATH)
	docker stop flow_build
	docker rm   -f flow_build