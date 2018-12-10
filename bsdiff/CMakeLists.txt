#
# Copyright (C) 2018 BMW Car IT GmbH
#

add_library(bsdiff SHARED
    brotli_decompressor.cc
    bspatch.cc
    bz2_decompressor.cc
    buffer_file.cc
    decompressor_interface.cc
    extents.cc
    extents_file.cc
    file.cc
    logging.cc
    memory_file.cc
    patch_reader.cc
    sink_file.cc
    utils.cc)
    
    
target_include_directories(bsdiff PUBLIC
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/bsdiff/include/
    ${PROJECT_SOURCE_DIR}/brotli/c/include/
    )

target_link_libraries(bsdiff brotlidec)

set_property(TARGET bsdiff PROPERTY POSITION_INDEPENDENT_CODE ON)
