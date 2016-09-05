# Script for building docker images
#   
#   
#  Dependencies
# └── base
#     ├── base-build
#     │   ├── flow-libs-dev-dbg
#     │   └── flow-libs-dev-rel
#     └── flow-libs
#         └── flow123-install


.PHONY: all
all: base flow123-install base-build flow-libs-dev-dbg flow-libs flow-libs-dev-rel
	@echo "building image flow123d/all"
	docker build --tag flow123d/all                   all

.PHONY: base
base: 
	@echo "building image flow123d/base"
	docker build --tag flow123d/base                  base

.PHONY: flow123-install
flow123-install: 
	@echo "building image flow123d/flow123-install"
	docker build --tag flow123d/flow123-install       flow123-install

.PHONY: base-build
base-build: base
	@echo "building image flow123d/base-build"
	docker build --tag flow123d/base-build            base-build

.PHONY: flow-libs-dev-dbg
flow-libs-dev-dbg: base-build
	@echo "building image flow123d/flow-libs-dev-dbg"
	docker build --tag flow123d/flow-libs-dev-dbg     flow-libs-dev-dbg

.PHONY: flow-libs
flow-libs: base flow-libs
	@echo "building image flow123d/flow-libs"
	docker build --tag flow123d/flow-libs             flow-libs

.PHONY: flow-libs-dev-rel
flow-libs-dev-rel: base-build
	@echo "building image flow123d/flow-libs-dev-rel"
	docker build --tag flow123d/flow-libs-dev-rel     flow-libs-dev-rel

