message("┏━━━━━━━━━━━━━━━━━━━━━━━┓")
message("┃setting cmake commands.┃")
message("┗━━━━━━━━━━━━━━━━━━━━━━━┛") 

cmake_policy(SET CMP0015 NEW)
cmake_policy(SET CMP0042 NEW)

# this extracts the first version only when the first version-like line in the changelog starts with `## vMAJOR.MINOR.PATCH`.
# If an earlier `v1.2.3` appears in a different form such as `### v1.2.3`, parsing fails.
# After calling it, these variables are available in the caller scope:
# - `BY_VER_MAJOR`
# - `BY_VER_MINOR`
# - `BY_VER_PATCH`
function(by_parse_ver CHANGELOG_PATH)
    get_filename_component(_by_changelog_path "${CHANGELOG_PATH}" ABSOLUTE BASE_DIR "${CMAKE_CURRENT_LIST_DIR}")
    if(NOT EXISTS "${_by_changelog_path}")
        message(FATAL_ERROR "by_parse_ver: changelog file not found: ${_by_changelog_path}")
    endif()

    file(STRINGS "${_by_changelog_path}" _by_changelog_lines)
    foreach(_by_line IN LISTS _by_changelog_lines)
        if("${_by_line}" MATCHES "v[0-9]+\\.[0-9]+\\.[0-9]+")
            if("${_by_line}" MATCHES "^##[ ]+v([0-9]+)\\.([0-9]+)\\.([0-9]+)([ ]|$)")
                set(BY_VER_MAJOR "${CMAKE_MATCH_1}" PARENT_SCOPE)
                set(BY_VER_MINOR "${CMAKE_MATCH_2}" PARENT_SCOPE)
                set(BY_VER_PATCH "${CMAKE_MATCH_3}" PARENT_SCOPE)
                return()
            endif()

            message(FATAL_ERROR "by_parse_ver: the first version-like line must start with '## vMAJOR.MINOR.PATCH': ${_by_line}")
        endif()
    endforeach()

    message(FATAL_ERROR "by_parse_ver: no version header matching '## vMAJOR.MINOR.PATCH' was found in ${_by_changelog_path}")
endfunction()

include_directories(${BY_DEFAULT_INC_DIR})

add_definitions(${CXX_DEFINITIONS})
message("\n")
