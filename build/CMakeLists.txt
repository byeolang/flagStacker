cmake_minimum_required (VERSION 3.14)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../external/build-common)
get_property(build_common_included GLOBAL PROPERTY BUILD_COMMON_INCLUDED)

if(NOT build_common_included)
    include(buildCommonPre)
endif()

project(flagStacker C CXX)

if(NOT build_common_included)
    include(buildCommon)

    # parse version
    by_parse_ver("${CMAKE_CURRENT_SOURCE_DIR}/../CHANGELOGS.md")
    set(VERSION_NAME "") # don't use version name in default
endif()

add_subdirectory(${BY_MODULE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/module)
