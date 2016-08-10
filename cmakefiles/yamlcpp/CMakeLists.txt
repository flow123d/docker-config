cmake_minimum_required(VERSION 2.8)

project(YAML_CPP CXX C)

set(YAML_CPP_VERSION_MAJOR "0")
set(YAML_CPP_VERSION_MINOR "5")
set(YAML_CPP_VERSION_PATCH "2")
set(YAML_CPP_VERSION "${YAML_CPP_VERSION_MAJOR}.${YAML_CPP_VERSION_MINOR}.${YAML_CPP_VERSION_PATCH}")

# default variables
set(INSTALL_DIR "${CMAKE_BINARY_DIR}")
set(INSTALL_URL "https://github.com/flow123d/yaml-cpp/archive/master.zip")


# setup external project with target external-lib
include(ExternalProject)
ExternalProject_Add(external-lib
    DOWNLOAD_DIR        ${INSTALL_DIR}
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${INSTALL_DIR}/src
    BINARY_DIR          ${INSTALL_DIR}/src
    CONFIGURE_COMMAND   cmake -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}.
    BUILD_COMMAND       make yaml-cpp
    INSTALL_COMMAND     ""
)


install(
    DIRECTORY ${INSTALL_DIR}/src/
    DESTINATION lib/yaml-cpp/
    FILES_MATCHING PATTERN "*.a"
)

install(
    DIRECTORY ${INSTALL_DIR}/src/include/yaml-cpp/
    DESTINATION include/yaml-cpp/
)

# CPack configuration
# set(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
set(CPACK_PACKAGE_FILE_NAME "YAML_CPP_${YAML_CPP_VERSION}")
set(CPACK_GENERATOR "DEB;TGZ;ZIP")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)
