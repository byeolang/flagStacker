CMAKE_MINIMUM_REQUIRED(VERSION 3.14)

include(FetchContent)

# fetching indep:
FetchContent_Declare(
    indep_dep
    SOURCE_SUBDIR build
    GIT_REPOSITORY https://github.com/byeolang/indep/
    GIT_TAG v0.1.0
)
FetchContent_MakeAvailable(indep_dep)

set(moduleName "flagStacker")
message("building ${moduleName}...")

message("\tconfigure_files...")
set(defCandidates "__${moduleName}=1")
foreach(def ${defCandidates})
    message("\tadd define ${def}")
    set(defines ${defines} -D${def})
endforeach(def)
add_definitions(${defines})

set(dependencies indep)

#  defines:
#      define libraries:
foreach(e ${dependencies})
    message("\tlinking ${e}")
endforeach(e)
#      define sources:
file(GLOB_RECURSE sources
    "*.c"
    "*.cpp"
)
#          logging sources:
foreach(e ${sources})
    message("\tembeding ${e}")
endforeach(e)

#  execute:
IF(EMSCRIPTEN)
    add_library(${moduleName} ${sources})
ELSE(EMSCRIPTEN)
    add_library(${moduleName} SHARED ${sources})
    install(TARGETS ${moduleName} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib PERMISSIONS
        OWNER_WRITE OWNER_READ OWNER_EXECUTE
        GROUP_READ GROUP_EXECUTE
        WORLD_READ WORLD_EXECUTE)
ENDIF(EMSCRIPTEN)
set_target_properties(${moduleName} PROPERTIES SUFFIX ".${BY_LIBRARY_EXTENSION}")
target_link_libraries(${moduleName} ${dependencies})

# export headers:
target_include_directories(${moduleName}
    PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>"
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

#       let MSVC follow macro expansion of standard:
if ((MSVC) AND (MSVC_VERSION GREATER_EQUAL 1914))
    target_compile_options(${moduleName} PUBLIC "/Zc:preprocessor")
endif()

get_target_property(_my_inc flagStacker
    INTERFACE_INCLUDE_DIRECTORIES)
message(STATUS "flagStacker self includes = ${_my_inc}")
