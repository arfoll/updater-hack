#
# Copyright (C) 2018 BMW Car IT GmbH
#

execute_process(COMMAND "flex"  "-o"  "lex.yy.cpp" "lexer.ll"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
execute_process(COMMAND "yacc" "-d" "parser.yy"
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
execute_process(COMMAND "mv" "y.tab.c" "y.tab.cpp"
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
execute_process(COMMAND "cp" "y.tab.h" "parser.h"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})


add_library(edify SHARED
    expr.cpp
    lex.yy.cpp
    y.tab.cpp)
target_include_directories(edify PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include/
    ${PROJECT_SOURCE_DIR}/base/include/
    ${PROJECT_SOURCE_DIR}/otautil/include/
    )

target_link_libraries(edify base otautil)

set_property(TARGET edify PROPERTY POSITION_INDEPENDENT_CODE ON)
