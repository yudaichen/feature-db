# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libunwind_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(libunwind_FRAMEWORKS_FOUND_RELEASE "${libunwind_FRAMEWORKS_RELEASE}" "${libunwind_FRAMEWORK_DIRS_RELEASE}")

set(libunwind_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libunwind_DEPS_TARGET)
    add_library(libunwind_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libunwind_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${libunwind_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${libunwind_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:LibLZMA::LibLZMA;ZLIB::ZLIB;libunwind::unwind;libunwind::generic>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libunwind_DEPS_TARGET to all of them
conan_package_library_targets("${libunwind_LIBS_RELEASE}"    # libraries
                              "${libunwind_LIB_DIRS_RELEASE}" # package_libdir
                              "${libunwind_BIN_DIRS_RELEASE}" # package_bindir
                              "${libunwind_LIBRARY_TYPE_RELEASE}"
                              "${libunwind_IS_HOST_WINDOWS_RELEASE}"
                              libunwind_DEPS_TARGET
                              libunwind_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "libunwind"    # package_name
                              "${libunwind_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libunwind_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Release ########################################

    ########## COMPONENT libunwind::coredump #############

        set(libunwind_libunwind_coredump_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libunwind_libunwind_coredump_FRAMEWORKS_FOUND_RELEASE "${libunwind_libunwind_coredump_FRAMEWORKS_RELEASE}" "${libunwind_libunwind_coredump_FRAMEWORK_DIRS_RELEASE}")

        set(libunwind_libunwind_coredump_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libunwind_libunwind_coredump_DEPS_TARGET)
            add_library(libunwind_libunwind_coredump_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libunwind_libunwind_coredump_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libunwind_libunwind_coredump_DEPS_TARGET' to all of them
        conan_package_library_targets("${libunwind_libunwind_coredump_LIBS_RELEASE}"
                              "${libunwind_libunwind_coredump_LIB_DIRS_RELEASE}"
                              "${libunwind_libunwind_coredump_BIN_DIRS_RELEASE}" # package_bindir
                              "${libunwind_libunwind_coredump_LIBRARY_TYPE_RELEASE}"
                              "${libunwind_libunwind_coredump_IS_HOST_WINDOWS_RELEASE}"
                              libunwind_libunwind_coredump_DEPS_TARGET
                              libunwind_libunwind_coredump_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libunwind_libunwind_coredump"
                              "${libunwind_libunwind_coredump_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libunwind::coredump
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libunwind_libunwind_coredump_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libunwind::coredump
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libunwind_libunwind_coredump_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libunwind::coredump PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET libunwind::coredump PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::coredump PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::coredump PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET libunwind::coredump PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_coredump_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## COMPONENT libunwind::setjmp #############

        set(libunwind_libunwind_setjmp_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libunwind_libunwind_setjmp_FRAMEWORKS_FOUND_RELEASE "${libunwind_libunwind_setjmp_FRAMEWORKS_RELEASE}" "${libunwind_libunwind_setjmp_FRAMEWORK_DIRS_RELEASE}")

        set(libunwind_libunwind_setjmp_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libunwind_libunwind_setjmp_DEPS_TARGET)
            add_library(libunwind_libunwind_setjmp_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libunwind_libunwind_setjmp_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libunwind_libunwind_setjmp_DEPS_TARGET' to all of them
        conan_package_library_targets("${libunwind_libunwind_setjmp_LIBS_RELEASE}"
                              "${libunwind_libunwind_setjmp_LIB_DIRS_RELEASE}"
                              "${libunwind_libunwind_setjmp_BIN_DIRS_RELEASE}" # package_bindir
                              "${libunwind_libunwind_setjmp_LIBRARY_TYPE_RELEASE}"
                              "${libunwind_libunwind_setjmp_IS_HOST_WINDOWS_RELEASE}"
                              libunwind_libunwind_setjmp_DEPS_TARGET
                              libunwind_libunwind_setjmp_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libunwind_libunwind_setjmp"
                              "${libunwind_libunwind_setjmp_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libunwind::setjmp
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libunwind_libunwind_setjmp_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libunwind::setjmp
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libunwind_libunwind_setjmp_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libunwind::setjmp PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET libunwind::setjmp PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::setjmp PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::setjmp PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET libunwind::setjmp PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_setjmp_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## COMPONENT libunwind::ptrace #############

        set(libunwind_libunwind_ptrace_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libunwind_libunwind_ptrace_FRAMEWORKS_FOUND_RELEASE "${libunwind_libunwind_ptrace_FRAMEWORKS_RELEASE}" "${libunwind_libunwind_ptrace_FRAMEWORK_DIRS_RELEASE}")

        set(libunwind_libunwind_ptrace_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libunwind_libunwind_ptrace_DEPS_TARGET)
            add_library(libunwind_libunwind_ptrace_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libunwind_libunwind_ptrace_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libunwind_libunwind_ptrace_DEPS_TARGET' to all of them
        conan_package_library_targets("${libunwind_libunwind_ptrace_LIBS_RELEASE}"
                              "${libunwind_libunwind_ptrace_LIB_DIRS_RELEASE}"
                              "${libunwind_libunwind_ptrace_BIN_DIRS_RELEASE}" # package_bindir
                              "${libunwind_libunwind_ptrace_LIBRARY_TYPE_RELEASE}"
                              "${libunwind_libunwind_ptrace_IS_HOST_WINDOWS_RELEASE}"
                              libunwind_libunwind_ptrace_DEPS_TARGET
                              libunwind_libunwind_ptrace_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libunwind_libunwind_ptrace"
                              "${libunwind_libunwind_ptrace_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libunwind::ptrace
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libunwind_libunwind_ptrace_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libunwind::ptrace
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libunwind_libunwind_ptrace_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libunwind::ptrace PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET libunwind::ptrace PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::ptrace PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::ptrace PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET libunwind::ptrace PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_ptrace_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## COMPONENT libunwind::generic #############

        set(libunwind_libunwind_generic_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libunwind_libunwind_generic_FRAMEWORKS_FOUND_RELEASE "${libunwind_libunwind_generic_FRAMEWORKS_RELEASE}" "${libunwind_libunwind_generic_FRAMEWORK_DIRS_RELEASE}")

        set(libunwind_libunwind_generic_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libunwind_libunwind_generic_DEPS_TARGET)
            add_library(libunwind_libunwind_generic_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libunwind_libunwind_generic_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libunwind_libunwind_generic_DEPS_TARGET' to all of them
        conan_package_library_targets("${libunwind_libunwind_generic_LIBS_RELEASE}"
                              "${libunwind_libunwind_generic_LIB_DIRS_RELEASE}"
                              "${libunwind_libunwind_generic_BIN_DIRS_RELEASE}" # package_bindir
                              "${libunwind_libunwind_generic_LIBRARY_TYPE_RELEASE}"
                              "${libunwind_libunwind_generic_IS_HOST_WINDOWS_RELEASE}"
                              libunwind_libunwind_generic_DEPS_TARGET
                              libunwind_libunwind_generic_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libunwind_libunwind_generic"
                              "${libunwind_libunwind_generic_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libunwind::generic
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libunwind_libunwind_generic_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libunwind::generic
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libunwind_libunwind_generic_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libunwind::generic PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET libunwind::generic PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::generic PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::generic PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET libunwind::generic PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_generic_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## COMPONENT libunwind::unwind #############

        set(libunwind_libunwind_unwind_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libunwind_libunwind_unwind_FRAMEWORKS_FOUND_RELEASE "${libunwind_libunwind_unwind_FRAMEWORKS_RELEASE}" "${libunwind_libunwind_unwind_FRAMEWORK_DIRS_RELEASE}")

        set(libunwind_libunwind_unwind_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libunwind_libunwind_unwind_DEPS_TARGET)
            add_library(libunwind_libunwind_unwind_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libunwind_libunwind_unwind_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libunwind_libunwind_unwind_DEPS_TARGET' to all of them
        conan_package_library_targets("${libunwind_libunwind_unwind_LIBS_RELEASE}"
                              "${libunwind_libunwind_unwind_LIB_DIRS_RELEASE}"
                              "${libunwind_libunwind_unwind_BIN_DIRS_RELEASE}" # package_bindir
                              "${libunwind_libunwind_unwind_LIBRARY_TYPE_RELEASE}"
                              "${libunwind_libunwind_unwind_IS_HOST_WINDOWS_RELEASE}"
                              libunwind_libunwind_unwind_DEPS_TARGET
                              libunwind_libunwind_unwind_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libunwind_libunwind_unwind"
                              "${libunwind_libunwind_unwind_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libunwind::unwind
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_LIBRARIES_TARGETS}>
                     APPEND)

        if("${libunwind_libunwind_unwind_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libunwind::unwind
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         libunwind_libunwind_unwind_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET libunwind::unwind PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET libunwind::unwind PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::unwind PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET libunwind::unwind PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET libunwind::unwind PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libunwind_libunwind_unwind_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET libunwind::libunwind PROPERTY INTERFACE_LINK_LIBRARIES libunwind::coredump APPEND)
    set_property(TARGET libunwind::libunwind PROPERTY INTERFACE_LINK_LIBRARIES libunwind::setjmp APPEND)
    set_property(TARGET libunwind::libunwind PROPERTY INTERFACE_LINK_LIBRARIES libunwind::ptrace APPEND)
    set_property(TARGET libunwind::libunwind PROPERTY INTERFACE_LINK_LIBRARIES libunwind::generic APPEND)
    set_property(TARGET libunwind::libunwind PROPERTY INTERFACE_LINK_LIBRARIES libunwind::unwind APPEND)

########## For the modules (FindXXX)
set(libunwind_LIBRARIES_RELEASE libunwind::libunwind)
