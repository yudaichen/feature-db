########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(dbg-macro_FIND_QUIETLY)
    set(dbg-macro_MESSAGE_MODE VERBOSE)
else()
    set(dbg-macro_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/dbg-macroTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${dbg-macro_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(dbg-macro_VERSION_STRING "0.5.1")
set(dbg-macro_INCLUDE_DIRS ${dbg-macro_INCLUDE_DIRS_RELEASE} )
set(dbg-macro_INCLUDE_DIR ${dbg-macro_INCLUDE_DIRS_RELEASE} )
set(dbg-macro_LIBRARIES ${dbg-macro_LIBRARIES_RELEASE} )
set(dbg-macro_DEFINITIONS ${dbg-macro_DEFINITIONS_RELEASE} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${dbg-macro_BUILD_MODULES_PATHS_RELEASE} )
    message(${dbg-macro_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


