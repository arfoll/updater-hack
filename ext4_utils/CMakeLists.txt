#
# Copyright (C) 2018 BMW Car IT GmbH
#

file(GLOB SRCS *.cpp)

add_library(ext4_utils SHARED
    ${SRCS})

target_include_directories(ext4_utils PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/base/include/
    ${PROJECT_SOURCE_DIR}/libcutils/include/
    )
    
target_link_libraries(ext4_utils)

set_property(TARGET ext4_utils PROPERTY POSITION_INDEPENDENT_CODE ON)
