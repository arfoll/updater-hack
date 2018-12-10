#
# Copyright (C) 2018 BMW Car IT GmbH
#

add_library(base SHARED
    file.cpp 
    logging.cpp
    parsenetaddress.cpp
    quick_exit.cpp
    stringprintf.cpp
    strings.cpp
    test_utils.cpp)

target_include_directories(base PUBLIC ${PROJECT_SOURCE_DIR}/base/include)
set_property(TARGET base PROPERTY POSITION_INDEPENDENT_CODE ON)
