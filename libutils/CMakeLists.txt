#
# Copyright (C) 2018 BMW Car IT GmbH
#

add_library(filemap SHARED
    FileMap.cpp)

target_include_directories(filemap PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    )

set_property(TARGET filemap PROPERTY POSITION_INDEPENDENT_CODE ON)
