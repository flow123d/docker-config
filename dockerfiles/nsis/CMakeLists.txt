# project name
project(Flow123d C)

# minimum version
cmake_minimum_required(VERSION 2.8.8)

# configurable via makefile
SET(IMAGE_NAME          "flow123d/v200" CACHE STRING "Windows image name.")

# flow image variables
set(FLOW_IMAGE_NAME     "flow123d-image.tar.gz")
set(FLOW_IMAGE_PATH     "${CMAKE_SOURCE_DIR}/libs/${FLOW_IMAGE_NAME}")

# docker toolbox variables
set(DOCKER_TOOLBOX_URL  "https://github.com/docker/toolbox/releases/download/v1.12.2/DockerToolbox-1.12.2.exe")
set(DOCKER_TOOLBOX_NAME "DockerToolbox-1.12.2.exe")
set(DOCKER_TOOLBOX_PATH "${CMAKE_SOURCE_DIR}/libs/${DOCKER_TOOLBOX_NAME}")

# shortcuts from install rules
set(SRC ${CMAKE_SOURCE_DIR}/src)
set(BLD ${CMAKE_BINARY_DIR})


# prepare image
if(NOT EXISTS ${FLOW_IMAGE_PATH})
    message(FATAL_ERROR "Flow123d image missing. Could not build install binary.")
endif()

# prepare docker toolbox
if(NOT EXISTS ${DOCKER_TOOLBOX_PATH})
    message(STATUS "Downloading ${DOCKER_TOOLBOX_NAME}")
    file(DOWNLOAD ${DOCKER_TOOLBOX_URL} ${DOCKER_TOOLBOX_PATH} SHOW_PROGRESS)
endif()


# Add configured files from build dir
configure_file(${SRC}/templates/install.sh      ${BLD}/bin/install.sh    @ONLY)
configure_file(${SRC}/templates/install.ps1     ${BLD}/bin/install.ps1   @ONLY)
configure_file(${SRC}/templates/uninstall.ps1   ${BLD}/bin/uninstall.ps1 @ONLY)
configure_file(${SRC}/templates/run.sh          ${BLD}/bin/run.sh        @ONLY)

configure_file(${SRC}/templates/install.bat     ${BLD}/install.bat       @ONLY)
configure_file(${SRC}/templates/uninstall.bat   ${BLD}/uninstall.bat     @ONLY)

# Add configure and configure template from src
file(COPY ${SRC}/configure                   DESTINATION ${BLD}/bin)
file(COPY ${SRC}/templates/setup.template.sh DESTINATION ${BLD}/bin/templates)
 
 

# install rules
install(PROGRAMS  ${BLD}/install.bat   DESTINATION ./)
install(PROGRAMS  ${BLD}/uninstall.bat DESTINATION ./)

install(DIRECTORY ${BLD}/bin/  DESTINATION bin)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/libs/ DESTINATION libs)

# create NSIS installer
set(CPACK_GENERATOR "ZIP")
include(CPack)
