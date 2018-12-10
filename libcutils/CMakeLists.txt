#
# Copyright (C) 2018 BMW Car IT GmbH
#

file(GLOB SRCS *.cpp)

add_library(cutils SHARED
    ${SRCS})

target_include_directories(cutils PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/base/
    )
    
target_link_libraries(cutils)

set_property(TARGET cutils PROPERTY POSITION_INDEPENDENT_CODE ON)
