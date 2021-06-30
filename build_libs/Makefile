# This Makefile builds libraries used by Flow123d.
# It runs in the build-base container and resulting packages are placed to the build-run directory.

# variables from arguments
# 'build_type' - Debug or Release (cmake keywords)

build_type ?= Debug	

# lib_build version 3.1.0 (flow123d)
ver_yamlcpp=0.6.3
ver_armadillo=10.5.2
ver_mpich=3.4.2
ver_petsc=3.15.1
ver_bddcml=2.6

package_dir=/build_dir/packages
PKG_SFX=.tar.gz
yamlcpp_pack=$(package_dir)/yamlcpp_$(build_type)$(PKG_SFX)
armadillo_pack=$(package_dir)/armadillo_$(build_type)$(PKG_SFX)
mpich_pack=$(package_dir)/mpich_$(build_type)$(PKG_SFX)
petsc_pack=$(package_dir)/petsc_$(build_type)$(PKG_SFX)
bddcml_pack=$(package_dir)/bddcml_$(build_type)$(PKG_SFX)

.PHONY : all-libs
all-libs: $(yamlcpp_pack) $(armadillo_pack) $(mpich_pack) $(petsc_pack) $(bddcml_pack)

	
$(yamlcpp_pack): common_cmake.mk yamlcpp/Makefile
	@echo "*** building YAMLCPP ***"
	make -C yamlcpp build_type=$(build_type) version=$(ver_yamlcpp) package


$(armadillo_pack): common_cmake.mk armadillo/Makefile
	@echo "*** building Armadillo ***"
	make -C armadillo build_type=$(build_type) version=$(ver_armadillo) package

	
$(mpich_pack): common_configure.mk mpich/Makefile
	@echo "*** building MPICH ***"
	make -C mpich build_type=$(build_type) version=$(ver_mpich) package
	

$(petsc_pack): $(mpich_pack) petsc/Makefile
	@echo "*** building PETSC ***"
	make -C petsc build_type=$(build_type) version=$(ver_petsc) mpich_lib=mpich_$(ver_mpich) package

$(bddcml_pack): $(mpich_pack) $(petsc_pack) bddcml/Makefile
	@echo "*** building BDDCML ***"
	make -C bddcml build_type=$(build_type) version=$(ver_bddcml) mpich_lib=mpich_$(ver_mpich) petsc_lib=petsc_$(ver_petsc) package
