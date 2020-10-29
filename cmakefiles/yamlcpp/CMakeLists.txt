cmake_minimum_required(VERSION 3.2)

project(YAMLCPP CXX C)
set(EXTRAS ${CMAKE_SOURCE_DIR}/../_CMake)
set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")

# default values
set(LIBRARY_VERSION   "0.6.3"   CACHE STRING "Version of the library")
set(LIBRARY_NAME      "yamlcpp" CACHE STRING "Name of the library")
set(LIBRARY_FULL_NAME "${LIBRARY_NAME}-${LIBRARY_VERSION}")

# default variables
set(INSTALL_DIR "${CMAKE_BINARY_DIR}")
set(INSTALL_URL "https://flow.nti.tul.cz/libraries/yaml-cpp-yaml-cpp-${LIBRARY_VERSION}.zip")


message(STATUS "------------------------------------------------------")
message(STATUS "LIBRARY_NAME          = ${LIBRARY_NAME}")
message(STATUS "LIBRARY_VERSION       = ${LIBRARY_VERSION}")
message(STATUS "CMAKE_INSTALL_PREFIX  = ${CMAKE_INSTALL_PREFIX}")
message(STATUS "------------------------------------------------------")

# --------------------------------------------------------------------
find_package(Threads)

# setup external project with target external-lib
include(ExternalProject)
ExternalProject_Add(external-lib
    DOWNLOAD_DIR        ${INSTALL_DIR}
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    BINARY_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    CONFIGURE_COMMAND   cmake -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} .
    BUILD_COMMAND       make
    INSTALL_COMMAND     make install
)

# install all which is located in the LIBRARY_FULL_NAME value
install(
    DIRECTORY ${CMAKE_INSTALL_PREFIX}/
    DESTINATION ./
    USE_SOURCE_PERMISSIONS
)

# CPack configuration
set(CPACK_PACKAGE_FILE_NAME "${LIBRARY_FULL_NAME}")
set(CPACK_PACKAGING_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
set(CPACK_GENERATOR "DEB;TGZ;ZIP")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)
