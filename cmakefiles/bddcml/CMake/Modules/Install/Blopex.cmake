

SET(INSTALL_URL "http://flow.nti.tul.cz/libraries/blopex-read-only.tar.gz")
set(MAKE_INC ${INSTALL_DIR}/blopex_make_inc)

# setup external project with target blopex-lib
include(ExternalProject)
ExternalProject_Add(blopex-lib
    DOWNLOAD_DIR        ${INSTALL_DIR}
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${BLOPEX_DIR}
    BINARY_DIR          ${BLOPEX_DIR}
    
    CONFIGURE_COMMAND   cp ${MAKE_INC} ${BLOPEX_DIR}/makefile.inc
    BUILD_COMMAND       make -j ${MAKE_NUMCPUS}
    INSTALL_COMMAND     ""
)

configure_file(
    ${CMAKE_SOURCE_DIR}/CMake/Templates/blopex_make_inc.template
    ${MAKE_INC}
    @ONLY)
