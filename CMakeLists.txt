#
# Copyright (C) 2018 BMW Car IT GmbH
#

cmake_minimum_required(VERSION 3.5)

project(sys-poc VERSION 1.0)

add_subdirectory(base)
add_subdirectory(brotli)
add_subdirectory(bsdiff)
add_subdirectory(otautil)
add_subdirectory(edify)
add_subdirectory(libutils)
add_subdirectory(libziparchive)
add_subdirectory(libcutils)
add_subdirectory(ext4_utils)
add_subdirectory(fec)
add_subdirectory(applypatch)
add_subdirectory(updater)
