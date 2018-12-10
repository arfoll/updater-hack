#
# Copyright (C) 2018 BMW Car IT GmbH
#

add_executable(updater
    updater.cpp
    blockimg.cpp
    commands.cpp
    install.cpp)


include(FindBZip2)
include(FindZLIB)
include(FindOpenSSL)
find_package (Threads)
message(STATUS "Using BZip2 version ${BZIP2_VERSION_STRING}")
message(STATUS "Using openssl version ${OPENSSL_VERSION}")
message(STATUS "Using zlib version ${ZLIB_VERSION_STRING}")

set_target_properties(updater PROPERTIES
    CXX_STANDARD 17
    )
target_include_directories(updater PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/base/include
    ${PROJECT_SOURCE_DIR}/bsdiff/include
    ${PROJECT_SOURCE_DIR}/edify/include
    ${PROJECT_SOURCE_DIR}/otautil/include
    ${PROJECT_SOURCE_DIR}/libziparchive/include
    ${PROJECT_SOURCE_DIR}/applypatch/include
    ${PROJECT_SOURCE_DIR}/brotli/include
    ${PROJECT_SOURCE_DIR}/ext4_utils/include
    ${BZIP2_INCLUDE_DIRS}
    ${OPENSSL_INCLUDE_DIR}
    )
    
target_link_libraries(updater bsdiff base cutils ziparchive cutils applypatch filemap otautil edify brotlidec 
    ${BZIP2_LIBRARIES}
    ${OPENSSL_LIBRARIES}
    ${CMAKE_THREAD_LIBS_INIT}
    ${ZLIB_LIBRARIES})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive")
set_property(TARGET updater PROPERTY POSITION_INDEPENDENT_CODE ON)
