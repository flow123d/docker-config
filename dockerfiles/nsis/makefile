
# defaut image name
IMAGE_NAME=flow123d/v200


# default target
all:
	# rm -rf build && mkdir -p build
	mkdir -p build
	cd build && cmake -DIMAGE_NAME=$(IMAGE_NAME) ..
	make -C build package
.PHONY: all