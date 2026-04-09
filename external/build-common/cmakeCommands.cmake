message("┏━━━━━━━━━━━━━━━━━━━━━━━┓")
message("┃setting cmake commands.┃")
message("┗━━━━━━━━━━━━━━━━━━━━━━━┛") 

cmake_policy(SET CMP0015 NEW)
cmake_policy(SET CMP0042 NEW)

include_directories(${BY_DEFAULT_INC_DIR})

add_definitions(${CXX_DEFINITIONS})
message("\n")
