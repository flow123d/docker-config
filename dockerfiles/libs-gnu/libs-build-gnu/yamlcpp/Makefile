# Simple makefile for building and packaging project Yaml cpp

library=yamlcpp
url=https://flow.nti.tul.cz/libraries/yaml-cpp-yaml-cpp-$(version).zip
base_name=yaml-cpp-yaml-cpp-$(version)
cmake_options="-DYAML_BUILD_SHARED_LIBS=ON"

# In order to combine staticaly linked yamlcpp with dynamicaly linked res of the code.
CXX_FLAGS=-fPIC

# TODO: shared yamplcpp


include ../common_cmake.mk


