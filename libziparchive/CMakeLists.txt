#
# Copyright (C) 2018 BMW Car IT GmbH
#

add_library(ziparchive SHARED
    zip_archive.cc
    zip_archive_stream_entry.cc
    zip_writer.cc)


set_target_properties(ziparchive PROPERTIES
    CXX_STANDARD 17
)

target_include_directories(ziparchive PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/base/include/
    ${PROJECT_SOURCE_DIR}/libutils/include/
    )

target_link_libraries(ziparchive base filemap)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive")
set_property(TARGET ziparchive PROPERTY POSITION_INDEPENDENT_CODE ON)
