cmake_minimum_required (VERSION 3.14)
project(flagStacker C CXX)

get_property(build_common_included GLOBAL PROPERTY BUILD_COMMON_INCLUDED)
if(NOT build_common_included)
    list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../external/build-common)
    include(buildCommon)
endif()

add_subdirectory(${BY_MODULE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/module)
