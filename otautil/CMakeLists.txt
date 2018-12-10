#
# Copyright (C) 2018 BMW Car IT GmbH
#

file(GLOB SRCS *.cpp)

add_library(otautil SHARED
    ${SRCS})
set_target_properties(otautil PROPERTIES
    CXX_STANDARD 17
    )
target_include_directories(otautil PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/base/include/
    )
    
target_link_libraries(otautil base)

set_property(TARGET otautil PROPERTY POSITION_INDEPENDENT_CODE ON)
