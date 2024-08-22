# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(gflags_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(gflags_FRAMEWORKS_FOUND_RELEASE "${gflags_FRAMEWORKS_RELEASE}" "${gflags_FRAMEWORK_DIRS_RELEASE}")

set(gflags_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET gflags_DEPS_TARGET)
    add_library(gflags_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET gflags_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${gflags_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${gflags_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### gflags_DEPS_TARGET to all of them
conan_package_library_targets("${gflags_LIBS_RELEASE}"    # libraries
                              "${gflags_LIB_DIRS_RELEASE}" # package_libdir
                              "${gflags_BIN_DIRS_RELEASE}" # package_bindir
                              "${gflags_LIBRARY_TYPE_RELEASE}"
                              "${gflags_IS_HOST_WINDOWS_RELEASE}"
                              gflags_DEPS_TARGET
                              gflags_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "gflags"    # package_name
                              "${gflags_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${gflags_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${gflags_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${gflags_LIBRARIES_TARGETS}>
                 APPEND)

    if("${gflags_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET gflags::gflags
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     gflags_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${gflags_LINKER_FLAGS_RELEASE}> APPEND)
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${gflags_INCLUDE_DIRS_RELEASE}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${gflags_LIB_DIRS_RELEASE}> APPEND)
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${gflags_COMPILE_DEFINITIONS_RELEASE}> APPEND)
    set_property(TARGET gflags::gflags
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${gflags_COMPILE_OPTIONS_RELEASE}> APPEND)

########## For the modules (FindXXX)
set(gflags_LIBRARIES_RELEASE gflags::gflags)
