# makefile for installing flow123d

FLOW = /opt/flow123d/flow123d


.PHONY: debug-configure
debug-configure:
	git clone -b JHy_docker https://github.com/jbrezmorf/flow123d.git $(FLOW)
	cp $(FLOW)/config/config-jenkins-docker-debug.cmake $(FLOW)/config.cmake
	make -C $(FLOW) cmake


.PHONY: debug
debug: debug-configure
	make -C $(FLOW) -j4 all
	make -C $(FLOW)/build_tree/unit_tests -j4 gtest_mpi_obj


.PHONY: unit/%
unit/%:
	make -C $(FLOW)/build_tree/unit_tests/$@ -k all-test
	
	
.PHONY: int/%
int/%:
	make -C $(FLOW)/tests/$@ test-all