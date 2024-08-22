# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(dbg-macro_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(dbg-macro_FRAMEWORKS_FOUND_RELEASE "${dbg-macro_FRAMEWORKS_RELEASE}" "${dbg-macro_FRAMEWORK_DIRS_RELEASE}")

set(dbg-macro_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET dbg-macro_DEPS_TARGET)
    add_library(dbg-macro_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET dbg-macro_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${dbg-macro_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${dbg-macro_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### dbg-macro_DEPS_TARGET to all of them
conan_package_library_targets("${dbg-macro_LIBS_RELEASE}"    # libraries
                              "${dbg-macro_LIB_DIRS_RELEASE}" # package_libdir
                              "${dbg-macro_BIN_DIRS_RELEASE}" # package_bindir
                              "${dbg-macro_LIBRARY_TYPE_RELEASE}"
                              "${dbg-macro_IS_HOST_WINDOWS_RELEASE}"
                              dbg-macro_DEPS_TARGET
                              dbg-macro_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "dbg-macro"    # package_name
                              "${dbg-macro_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${dbg-macro_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET dbg-macro::dbg-macro
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${dbg-macro_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${dbg-macro_LIBRARIES_TARGETS}>
                 APPEND)

    if("${dbg-macro_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET dbg-macro::dbg-macro
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     dbg-macro_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET dbg-macro::dbg-macro
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${dbg-macro_LINKER_FLAGS_RELEASE}> APPEND)
    set_property(TARGET dbg-macro::dbg-macro
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${dbg-macro_INCLUDE_DIRS_RELEASE}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET dbg-macro::dbg-macro
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${dbg-macro_LIB_DIRS_RELEASE}> APPEND)
    set_property(TARGET dbg-macro::dbg-macro
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${dbg-macro_COMPILE_DEFINITIONS_RELEASE}> APPEND)
    set_property(TARGET dbg-macro::dbg-macro
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${dbg-macro_COMPILE_OPTIONS_RELEASE}> APPEND)

########## For the modules (FindXXX)
set(dbg-macro_LIBRARIES_RELEASE dbg-macro::dbg-macro)
