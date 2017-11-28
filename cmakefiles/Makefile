# This Makefile server for building and publish libraries
# using image flow123d/base-env (by default)
LIBRARY=$(@)
BUILD_TYPE=Debug
PACKAGE_DIR_REMOTE=/var/www/html/static/packages

DID=lib-$(LIBRARY)
IMAGE=flow123d/base-env

URL=
DEB_NAME=$(notdir $(URL))

.PHONY : publish
publish:
	@/bin/echo -e "\n=== Publishing image $(DID) ===\n"
	-docker exec $(DID) chown -R $(shell id -u) /tmp/work
	docker rm -f $(DID)
	scp -r $(CURDIR)/$(LIBRARY)/packages/* builder@ciflow.nti.tul.cz:$(PACKAGE_DIR_REMOTE)/

.PHONY : start-image
start-image:
	@/bin/echo -e "\n=== Starting image $(IMAGE) ===\n"
	-@docker rm -f $(DID) 2>/dev/null
	docker pull $(IMAGE)
	docker run --rm -di --name=$(DID) \
			--volume=$(CURDIR):/tmp/work \
			$(IMAGE)

.PHONY : install-lib
install-lib:
	@/bin/echo -e "\n=== Installing $(DEB_NAME) into $(DID) ===\n"
	-docker exec $(DID) wget -qO /tmp/$(DEB_NAME) $(URL)
	-docker exec $(DID) dpkg -i /tmp/$(DEB_NAME)
	-docker exec $(DID) rm -rf /tmp/$(DEB_NAME)

.PHONY : mpich
mpich:
	$(MAKE) LIBRARY=$(LIBRARY) CURDIR=$(CURDIR) IMAGE=$(IMAGE) start-image
	-docker exec $(DID) make -C /tmp/work/$(@) build_type=$(BUILD_TYPE) package
	$(MAKE) LIBRARY=$(LIBRARY) PACKAGE_DIR_REMOTE=$(PACKAGE_DIR_REMOTE) publish

.PHONY : petsc armadillo yamlcpp
petsc armadillo yamlcpp:
	$(MAKE) LIBRARY=$(LIBRARY) CURDIR=$(CURDIR) IMAGE=$(IMAGE) start-image
	$(MAKE) LIBRARY=$(LIBRARY) URL=http://ciflow.nti.tul.cz/static/packages/mpich_3.2.0_$(BUILD_TYPE)/mpich-3.2.0.deb install-lib
	-docker exec $(DID) /bin/bash -c "PATH=/usr/local/mpich-3.2.0/bin:\$$PATH make -C /tmp/work/$(@) build_type=$(BUILD_TYPE) package"
	$(MAKE) LIBRARY=$(LIBRARY) PACKAGE_DIR_REMOTE=$(PACKAGE_DIR_REMOTE) publish

.PHONY : bddcml
bddcml:
	$(MAKE) LIBRARY=$(LIBRARY) CURDIR=$(CURDIR) IMAGE=$(IMAGE) start-image
	$(MAKE) LIBRARY=$(LIBRARY) URL=http://ciflow.nti.tul.cz/static/packages/mpich_3.2.0_$(BUILD_TYPE)/mpich-3.2.0.deb install-lib
	$(MAKE) LIBRARY=$(LIBRARY) URL=http://ciflow.nti.tul.cz/static/packages/petsc_3.6.1_$(BUILD_TYPE)/petsc-3.6.1.deb install-lib
	-docker exec $(DID) /bin/bash -c "PATH=/usr/local/mpich-3.2.0/bin:\$$PATH make -C /tmp/work/$(@) build_type=$(BUILD_TYPE) package"
	$(MAKE) LIBRARY=$(LIBRARY) PACKAGE_DIR_REMOTE=$(PACKAGE_DIR_REMOTE) publish
