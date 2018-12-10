#
# Copyright (C) 2018 BMW Car IT GmbH
#

add_library(fec SHARED
    encode_rs_char.c
    decode_rs_char.c
    init_rs_char.c)
    
target_link_libraries(fec)

set_property(TARGET fec PROPERTY POSITION_INDEPENDENT_CODE ON)
