

# Conan automatically generated toolchain file
# DO NOT EDIT MANUALLY, it will be overwritten

# Avoid including toolchain file several times (bad if appending to variables like
#   CMAKE_CXX_FLAGS. See https://github.com/android/ndk/issues/323
include_guard()

message(STATUS "Using Conan toolchain: ${CMAKE_CURRENT_LIST_FILE}")

if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeToolchain' generator only works with CMake >= 3.15")
endif()




########## generic_system block #############
# Definition of system, platform and toolset
#############################################







string(APPEND CONAN_CXX_FLAGS " -m64")
string(APPEND CONAN_C_FLAGS " -m64")
string(APPEND CONAN_SHARED_LINKER_FLAGS " -m64")
string(APPEND CONAN_EXE_LINKER_FLAGS " -m64")



message(STATUS "Conan toolchain: C++ Standard 23 with extensions ON")
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Extra c, cxx, linkflags and defines


if(DEFINED CONAN_CXX_FLAGS)
  string(APPEND CMAKE_CXX_FLAGS_INIT " ${CONAN_CXX_FLAGS}")
endif()
if(DEFINED CONAN_C_FLAGS)
  string(APPEND CMAKE_C_FLAGS_INIT " ${CONAN_C_FLAGS}")
endif()
if(DEFINED CONAN_SHARED_LINKER_FLAGS)
  string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${CONAN_SHARED_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_EXE_LINKER_FLAGS)
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${CONAN_EXE_LINKER_FLAGS}")
endif()

get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(_CMAKE_IN_TRY_COMPILE)
    message(STATUS "Running toolchain IN_TRY_COMPILE")
    return()
endif()

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG ON)

# Definition of CMAKE_MODULE_PATH
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "/home/ydc/.conan2/p/boost79f537833cdae/p/lib" "/home/ydc/.conan2/p/bzip24ed69d4fecc16/p/lib" "/home/ydc/.conan2/p/libbab546f21710147/p/lib" "/home/ydc/.conan2/p/glogcfe960a48d0ca/p/lib" "/home/ydc/.conan2/p/gflagfd83e6ec61b29/p/lib" "/home/ydc/.conan2/p/libund3fdf53cc586b/p/lib" "/home/ydc/.conan2/p/xz_ut1cf28d476c611/p/lib" "/home/ydc/.conan2/p/zlib3579ae9197e0e/p/lib" "/home/ydc/.conan2/p/gtestf28c74556dabb/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/ydc/.conan2/p/boost79f537833cdae/p/include" "/home/ydc/.conan2/p/bzip24ed69d4fecc16/p/include" "/home/ydc/.conan2/p/libbab546f21710147/p/include" "/home/ydc/.conan2/p/nlohm0567ffc90cfc1/p/include" "/home/ydc/.conan2/p/glogcfe960a48d0ca/p/include" "/home/ydc/.conan2/p/gflagfd83e6ec61b29/p/include" "/home/ydc/.conan2/p/libund3fdf53cc586b/p/include" "/home/ydc/.conan2/p/xz_ut1cf28d476c611/p/include" "/home/ydc/.conan2/p/zlib3579ae9197e0e/p/include" "/home/ydc/.conan2/p/gtestf28c74556dabb/p/include" "/home/ydc/.conan2/p/dbg-mf7ad4338afcd6/p/include")



if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()




# Variables
# Variables  per configuration


# Preprocessor definitions
# Preprocessor definitions per configuration


if(CMAKE_POLICY_DEFAULT_CMP0091)  # Avoid unused and not-initialized warnings
endif()