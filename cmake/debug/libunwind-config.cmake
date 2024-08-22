########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(libunwind_FIND_QUIETLY)
    set(libunwind_MESSAGE_MODE VERBOSE)
else()
    set(libunwind_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libunwindTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${libunwind_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(libunwind_VERSION_STRING "1.7.2")
set(libunwind_INCLUDE_DIRS ${libunwind_INCLUDE_DIRS_RELEASE} )
set(libunwind_INCLUDE_DIR ${libunwind_INCLUDE_DIRS_RELEASE} )
set(libunwind_LIBRARIES ${libunwind_LIBRARIES_RELEASE} )
set(libunwind_DEFINITIONS ${libunwind_DEFINITIONS_RELEASE} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${libunwind_BUILD_MODULES_PATHS_RELEASE} )
    message(${libunwind_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()

