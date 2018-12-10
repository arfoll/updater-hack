#
# Copyright (C) 2018 BMW Car IT GmbH
#

add_library(applypatch SHARED
    applypatch.cpp
    freecache.cpp
    imgpatch.cpp
    bspatch.cpp)


include(FindBZip2)
include(FindOpenSSL)
message(STATUS "Using BZip2 version ${BZIP2_VERSION_STRING}")
message(STATUS "Using openssl version ${OPENSSL_VERSION}")

set_target_properties(applypatch PROPERTIES
    CXX_STANDARD 17
    )
target_include_directories(applypatch PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/base/include
    ${PROJECT_SOURCE_DIR}/bsdiff/include
    ${PROJECT_SOURCE_DIR}/edify/include
    ${PROJECT_SOURCE_DIR}/otautil/include
    ${BZIP2_INCLUDE_DIRS}
    ${OPENSSL_INCLUDE_DIR}
    )
    
target_link_libraries(applypatch bsdiff base otautil edify brotlidec ${BZIP2_LIBRARIES} ${OPENSSL_LIBRARIES})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive")
set_property(TARGET applypatch PROPERTY POSITION_INDEPENDENT_CODE ON)
