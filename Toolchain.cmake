cmake_minimum_required(VERSION 3.9 FATAL_ERROR)
set(SCHEOL_HOST_COMPILER_PREFIX "/usr/bin" CACHE STRING "Prefix path to search for host compilers")

# Swift Compiler Related
set(CMAKE_Swift_COMPILER "${SCHEOL_HOST_COMPILER_PREFIX}/swiftc")
execute_process(COMMAND ${CMAKE_Swift_COMPILER} "--version" OUTPUT_VARIABLE SWIFT_VERSION_STR OUTPUT_STRIP_TRAILING_WHITESPACE)
string(REGEX MATCH "Swift version ([0-9]\\.[0-9])" SWIFT_VERSION "${SWIFT_VERSION_STR}")
set(CMAKE_Swift_LANGUAGE_VERSION "${CMAKE_MATCH_1}")

# Setting C/C++ compiler since we need clang in MSVC compatible mode
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(CMAKE_C_COMPILER "${SCHEOL_HOST_COMPILER_PREFIX}/clang-cl")
    set(CMAKE_CXX_COMPILER "${SCHEOL_HOST_COMPILER_PREFIX}/clang-cl")
else()
    set(CMAKE_C_COMPILER "${SCHEOL_HOST_COMPILER_PREFIX}/clang")
    set(CMAKE_CXX_COMPILER "${SCHEOL_HOST_COMPILER_PREFIX}/clang++")
endif()

# Setting sysroot
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    include_directories(BEFORE SYSTEM "/Windows/crt/include" "/Windows/sdk/Include")
    link_directories(BEFORE "/Windows/crt/lib/${VCPKG_TARGET_ARCHITECTURE}" "/Windows/sdk/Lib/${VCPKG_TARGET_ARCHITECTURE}")
else()
    set(CMAKE_OSX_ARCHITECTURES ${CMAKE_SYSTEM_PROCESSOR})
    set(CMAKE_OSX_SYSROOT "/macOS/MacOSX${CMAKE_SYSTEM_VERSION}.sdk")
endif()








    