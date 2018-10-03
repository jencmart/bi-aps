cmake_minimum_required(VERSION 3.8)
project(chacheSem_final)

set(CMAKE_C_STANDARD 11)

set(SOURCE_FILES main.c)

add_executable(chacheSem_final ${SOURCE_FILES})

target_link_libraries(chacheSem_final m)