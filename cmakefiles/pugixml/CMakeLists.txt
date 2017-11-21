cmake_minimum_required(VERSION 2.8)

project(YAMLCPP CXX C)
#set(EXTRAS ${CMAKE_SOURCE_DIR}/../_CMake)
#set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")


#set(YAMLCPP_VERSION_MAJOR "0")
#set(YAMLCPP_VERSION_MINOR "5")
#set(YAMLCPP_VERSION_PATCH "2")
set(PUGIXML_VERSION "1.8.1")

# default variables
set(INSTALL_DIR "${CMAKE_BINARY_DIR}")
# set(INSTALL_URL "https://github.com/flow123d/yaml-cpp/archive/master.zip")
set(INSTALL_URL "http://flow.nti.tul.cz/libraries/pugixml-1.8.1.zip")


# setup external project with target external-lib
include(ExternalProject)
ExternalProject_Add(pugixml
    DOWNLOAD_DIR        ${INSTALL_DIR}
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    BINARY_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    CONFIGURE_COMMAND   cmake -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} .
    BUILD_COMMAND       make pugixml
    INSTALL_COMMAND     ""
)


install(
    DIRECTORY ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}/
    DESTINATION lib/pugixml/${CMAKE_BUILD_TYPE}/lib
    FILES_MATCHING PATTERN "*.a"
)

install(
    DIRECTORY ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}/include/
    DESTINATION lib/pugixml/${CMAKE_BUILD_TYPE}/include
)

# CPack configuration
# set(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
set(CPACK_PACKAGE_FILE_NAME "PUGIXML_${PUGIXML_VERSION}")
set(CPACK_GENERATOR "DEB;TGZ;ZIP")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)

