# Simple makefile for building and packaging project BDDCML and Blobex

library=bddcml
bddcml_url=http://flow.nti.tul.cz/libraries/bddcml-$(version).tar.gz
base_name=bddcml-$(version)
clear=false

build_root=/build_dir
build_dir     = $(build_root)/$(library)/build_$(build_type)
package_dir   = $(build_root)/packages
package_name  = $(library)_$(build_type)
package=$(package_dir)/$(package_name).tar.gz
n_jobs	      = 5


bddcml_install_file=$(notdir $(bddcml_url))

prefix=/usr/local/$(library)_$(version)

FC_FLAGS_Debug=-O3 -DNDEBUG -g
FC_FLAGS_Release=-O3 -DNDEBUG
CC_FLAGS_Debug=$(FC_FLAGS_Debug)
CC_FLAGS_Release=$(FC_FLAGS_Release)


# ********** BLOPEX build
blopex_build_dir=$(build_root)/bddcml/blopex_$(build_type)
blopex_make_inc=$(blopex_build_dir)/makefile.inc
blopex_url=http://flow.nti.tul.cz/libraries/blopex-read-only.tar.gz
blopex_install_file=$(notdir $(blopex_url))

$(blopex_install_file):
	wget $(blopex_url)

.PHONY : blopex_dir
blopex_dir: $(blopex_install_file)
	if [ ! -d $(blopex_build_dir) ]; then \
		cmake -E tar x $(blopex_install_file); \
		mv blopex-read-only blopex_$(build_type); \
	fi

$(blopex_make_inc): blopex_dir
	echo CC=/usr/bin/gcc >>$(blopex_make_inc)
	echo CC_FLAGS=$(CC_FLAGS_$(build_type)) >>$(blopex_make_inc)
	echo include $(blopex_build_dir)/../blopex_make_inc.common >>$(blopex_make_inc)
	
	
.PHONY: blopex_build
blopex_build: $(blopex_make_inc)
	cd $(blopex_build_dir) && make all
	
###################


.PHONY : clean_build
clean_build:
	@if [ "$(clear)" = "true" ]; then\
		rm -rf $(build_dir);\
	fi


$(bddcml_install_file):
	wget $(bddcml_url)
	

tmp_install_dir=$(build_dir)/installation_$(build_type)
.PHONY: build_dir
build_dir:  clean_build $(bddcml_install_file)
	if [ ! -d $(build_dir) ]; then \
		cmake -E tar x $(bddcml_install_file); \
		mv $(base_name) build_$(build_type); \
	fi
	# link prefix into mounted volume in order to preserve it 
	
	#However it seems that PETSC links all used libraries into single libpetsc.so, since all used libraries are static libraries.
	mkdir -p $(tmp_install_dir)
	
	# remove previous link
	if [ -d $(prefix) ]; then rm -rf $(prefix); fi
	
	sudo ln -s $(tmp_install_dir) $(prefix)
	ls -l $(prefix)

mpi_dir=/usr/local/$(mpich_lib)
full_mpich_lib=$(mpi_dir)/lib/libmpi.so
$(full_mpich_lib):
	cd /usr/local && sudo tar xzf $(package_dir)/mpich_$(build_type).tar.gz
	ls /usr/local

petsc_dir=/usr/local/$(petsc_lib)
full_petsc_lib=$(petsc_dir)/usr/local/$(petsc_lib)/lib/libpetsc.so
$(full_petsc_lib):
	cd /usr/local && sudo tar xzf $(package_dir)/petsc_$(build_type).tar.gz
	ls /usr/local
	
make_inc=$(build_dir)/make.inc
$(make_inc): clean_build build_dir blopex_build $(full_mpich_lib) $(full_petsc_lib)
	echo mpi_dir=$(mpi_dir) >$(make_inc)
	echo petsc_dir=$(petsc_dir) >>$(make_inc)
	echo blopex_dir=$(blopex_build_dir) >>$(make_inc)
	echo build_dir=$(build_dir) >>$(make_inc)
	echo fc_flags=$(FC_FLAGS_$(build_type)) >>$(make_inc)
	echo cc_flags=$(CC_FLAGS_$(build_type)) >>$(make_inc)
	echo include $(build_dir)/../bddcml_make_inc.common >>$(make_inc)


.PHONY : build
build: $(make_inc)
	ls $(petsc_dir)/include 
	cd $(build_dir) && make all


.PHONY : install
install: build
	#mkdir -p $(tmp_install_prefix)
	cp -r $(build_dir)/lib $(tmp_install_dir)
	mkdir -p $(tmp_install_dir)/include 
	cp $(build_dir)/src/bddcml_interface_c.h $(tmp_install_dir)/include
	

$(package): install
	mkdir -p $(package_dir)
	ls -l $(prefix)
	# dereference symlinked prefix directory
	cd /usr/local && tar cfvz  $(package) --dereference $(library)_$(version)
	ls /usr/local/$(library)_$(version)

.PHONY : package
package: $(package)



	
	

