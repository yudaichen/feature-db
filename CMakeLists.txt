cmake_minimum_required(VERSION 3.28.3)
#set(CMAKE_GENERATOR "/mnt/d/runtime/ninja-linux/ninja")
set(CMAKE_C_COMPILER "/usr/bin/clang-17")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++-17")
set(CMAKE_CXX_COMPILER_ID "Clang")
set(APP_NAME fast_experience)
project(${APP_NAME})

#c++23 标准
set(CMAKE_CXX_STANDARD 23)


#用于指定 CMake 是否将扫描目标中C++源以查找模块依赖项
#https://cmake.org/cmake/help/latest/prop_tgt/CXX_SCAN_FOR_MODULES.html#prop_tgt:CXX_SCAN_FOR_MODULES
set(CMAKE_CXX_SCAN_FOR_MODULES ON)

if (NOT CMAKE_GENERATOR STREQUAL "Ninja")
    message(FATAL_ERROR "This project requires the Ninja generator. Refers to https://cmake.org/cmake/help/latest/manual/cmake-cxxmodules.7.html#generator-support")
endif ()

execute_process(COMMAND ${CMAKE_CXX_COMPILER} --version OUTPUT_VARIABLE clang_full_version_string)
string(REGEX REPLACE ".*clang version ([0-9]+\\.[0-9]+).*" "\\1" CLANG_VERSION_STRING ${clang_full_version_string})
if (CLANG_VERSION_STRING VERSION_GREATER 16)
    # Print CMake version and project name
    message(STATUS "Building ${PROJECT_NAME} with CMake version: ${CMAKE_VERSION} On CLANG-${CLANG_VERSION_STRING}")
else ()
    message(FATAL_ERROR, "Please use clang version 17.0 and above")
endif ()

message(STATUS "Build type = ${CMAKE_BUILD_TYPE}")

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")

    set(CMAKE_CXX_FLAGS "-Ofast -DNDEBUG")
    set(CMAKE_C_FLAGS "-Ofast -DNDEBUG")

elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")

    set(CMAKE_CXX_FLAGS "-O2 -g -DNDEBUG")
    set(CMAKE_C_FLAGS "-O2 -g -DNDEBUG")

elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")

    set(CMAKE_CXX_FLAGS "-O0 -g -DNDEBUG")
    set(CMAKE_C_FLAGS "-O0 -g -DNDEBUG")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-stack-protector -fno-omit-frame-pointer -fno-var-tracking ")
    # -fsanitize=address拖慢速度
    # -Wno-sign-compare 忽略 int size不能比较
    #    set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fsanitize=memory -fno-omit-frame-pointer")
    #    set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fsanitize=thread -fno-omit-frame-pointer")
    #    set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fsanitize=undefined -fno-omit-frame-pointer")
    #    set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fsanitize=cfi -fno-omit-frame-pointer")
    set(CMAKE_DEBUG_POSTFIX "")

else ()
    message(FATAL_ERROR "Only support CMake build type: Release, Debug, and MinSizeRel")
endif ()


if (CLANG_VERSION_STRING VERSION_EQUAL 17)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -Wno-sign-compare -Wunused-result -Wno-deprecated-declarations -Wno-read-modules-implicitly -Wextra -Wno-unused-parameter -Wno-unused-private-field -pthread -fcolor-diagnostics ")
else ()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -Wno-sign-compare -Wunused-result -Wno-deprecated-declarations -Wextra -Wno-unused-parameter -Wno-unused-private-field -pthread -fcolor-diagnostics")
endif ()

MESSAGE(STATUS "C++ Compilation flags: " ${CMAKE_CXX_FLAGS})

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libstdc++ -static-libgcc -z noexecstack")

#add_definitions(-march=native)
if (CMAKE_C_COMPILER_ID STREQUAL "Clang" AND CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL "18.0")
    add_definitions(-mevex512)
endif ()


# 使用Gold链接器
if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=gold")
endif ()

# 使用LLD链接器
if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=lld-17")
endif ()

# 启用链接时优化 (Link Time Optimization, LTO)
# LTO可以让编译器在链接阶段进行代码优化，这有助于提高程序性能，有时也能减少链接时间。
include(CheckIPOSupported)
check_ipo_supported(RESULT result)
if (result)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
endif ()

# 对GCC和Clang，启用分割调试信息
if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -Wl,--gdb-index")
endif ()


# 使用test文件
set(USE_TEST true)


# 寻找第三方包
find_package(Boost REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(yaml-cpp CONFIG REQUIRED)
find_package(glog REQUIRED)
find_package(GTest REQUIRED)
find_package(dbg-macro REQUIRED)

#find_package(Hiredis REQUIRED PATHS  cmake/FindHiredis.cmake)
#find_package(Drogon CONFIG REQUIRED)

include_directories(${CMAKE_SOURCE_DIR})
include_directories(/usr/include)
# conan 第三方包头文件目录
include_directories(${CMAKE_INCLUDE_PATH})
# 本项目 内置头文件目录
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src/models)
include_directories(${macro_INCLUDE_DIRS_RELEASE})

# 添加库文件搜索路径
link_directories(/usr/lib/x86_64-linux-gnu)


# 编译期性能优化
find_program(CCACHE_PROGRAM ccache)
if (CCACHE_PROGRAM)
    message(STATUS "Set up ccache ...")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif ()


# 头文件
file(GLOB_RECURSE CURRENT_HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.hpp)

# 源文件
file(GLOB_RECURSE SOURCE_FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cc
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.ui
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.qrc
)

# 模块文件
file(GLOB_RECURSE MODULES_FILES
        CONFIGURE_DEPENDS
        ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cppm
)


# 使用test文件
if (USE_TEST)
    #测试文件
    set(TEST_FILE
            ${CMAKE_CURRENT_SOURCE_DIR}/run/test_main.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/test/std_coroutine.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/test/test_utils.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/test/raft_test.cpp
    )

    file(GLOB_RECURSE RAFT_TEST
            ${CMAKE_CURRENT_SOURCE_DIR}/test/raft/*.h
            ${CMAKE_CURRENT_SOURCE_DIR}/test/raft/*.cc

    )
else ()
    #可执行文件
    set(RUN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/run/main.cpp)
endif ()

add_executable(fast_experience
        ${CURRENT_HEADERS}
        ${SOURCE_FILES}
        ${TEST_FILE}
        ${RUN_FILE}
        ${RAFT_TEST}
)

#
target_sources(fast_experience
        PUBLIC
        FILE_SET core_cxx_modules TYPE CXX_MODULES FILES
        ${MODULES_FILES}
)

if (UES_PRECOMPILE)
    # 预编译头文件
    target_precompile_headers(
            fast_experience PRIVATE
            <boost/asio.hpp>
            <nlohmann/json.hpp>
            <yaml-cpp/yaml.h>
            <glog/logging.h>
    )
endif ()

target_link_directories(fast_experience PRIVATE /usr/local/lib)

set(Hiredis_lib libhiredis.a)
target_link_libraries(
        fast_experience
        pthread
        boost::boost
        glog
        gtest
        gflags
        nlohmann_json::nlohmann_json
        dbg-macro::dbg-macro

        libyaml-cpp.so

        z#[[   sudo apt-get install zlib1g-dev]]
)

if (USE_TEST)
    # gtest
    add_test(test_all ${APP_NAME})
endif ()


function(help_conan_1)

    note("\n\n\n\n*****************************use conan1.******************************\n")
    note("debug:     conan install . -s build_type=Debug --install-folder=./cmake/debug")
    note("release:   conan install . -s build_type=Debug --install-folder=./cmake/release\n
    libgtest-dev ccache libgrpc++-dev libbenchmark-dev librange-v3-dev libzmq3-dev nlohmann-json3-dev libleveldb-dev libfmt-dev libyaml-cpp-dev liburing-dev")
    note("\n*****************************end conan*****************************\n\n\n\n")

endfunction()

function(help_conan_2)

    note("\n\n\n\n*****************************use conan2.******************************\n")
    note("debug:   cd cmake/debug  conan install ../.. -of . --build missing")
    note("release: cd cmake/debug  conan install ../.. -of . --build missing\n")
    note("-of   conan_toolchain.cmake 文件输出目录")
    note("*****************************end conan*****************************\n\n\n\n")

endfunction()