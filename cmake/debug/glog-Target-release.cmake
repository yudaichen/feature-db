# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(glog_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(glog_FRAMEWORKS_FOUND_RELEASE "${glog_FRAMEWORKS_RELEASE}" "${glog_FRAMEWORK_DIRS_RELEASE}")

set(glog_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET glog_DEPS_TARGET)
    add_library(glog_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET glog_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${glog_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${glog_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:gflags::gflags;libunwind::libunwind>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### glog_DEPS_TARGET to all of them
conan_package_library_targets("${glog_LIBS_RELEASE}"    # libraries
                              "${glog_LIB_DIRS_RELEASE}" # package_libdir
                              "${glog_BIN_DIRS_RELEASE}" # package_bindir
                              "${glog_LIBRARY_TYPE_RELEASE}"
                              "${glog_IS_HOST_WINDOWS_RELEASE}"
                              glog_DEPS_TARGET
                              glog_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "glog"    # package_name
                              "${glog_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${glog_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${glog_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${glog_LIBRARIES_TARGETS}>
                 APPEND)

    if("${glog_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET glog::glog
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     glog_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${glog_LINKER_FLAGS_RELEASE}> APPEND)
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${glog_INCLUDE_DIRS_RELEASE}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${glog_LIB_DIRS_RELEASE}> APPEND)
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${glog_COMPILE_DEFINITIONS_RELEASE}> APPEND)
    set_property(TARGET glog::glog
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${glog_COMPILE_OPTIONS_RELEASE}> APPEND)

########## For the modules (FindXXX)
set(glog_LIBRARIES_RELEASE glog::glog)
