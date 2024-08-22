########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(gflags_COMPONENT_NAMES "")
set(gflags_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(gflags_PACKAGE_FOLDER_RELEASE "/home/ydc/.conan2/p/gflagfd83e6ec61b29/p")
set(gflags_BUILD_MODULES_PATHS_RELEASE )


set(gflags_INCLUDE_DIRS_RELEASE "${gflags_PACKAGE_FOLDER_RELEASE}/include")
set(gflags_RES_DIRS_RELEASE )
set(gflags_DEFINITIONS_RELEASE )
set(gflags_SHARED_LINK_FLAGS_RELEASE )
set(gflags_EXE_LINK_FLAGS_RELEASE )
set(gflags_OBJECTS_RELEASE )
set(gflags_COMPILE_DEFINITIONS_RELEASE )
set(gflags_COMPILE_OPTIONS_C_RELEASE )
set(gflags_COMPILE_OPTIONS_CXX_RELEASE )
set(gflags_LIB_DIRS_RELEASE "${gflags_PACKAGE_FOLDER_RELEASE}/lib")
set(gflags_BIN_DIRS_RELEASE )
set(gflags_LIBRARY_TYPE_RELEASE STATIC)
set(gflags_IS_HOST_WINDOWS_RELEASE 0)
set(gflags_LIBS_RELEASE gflags_nothreads)
set(gflags_SYSTEM_LIBS_RELEASE pthread m)
set(gflags_FRAMEWORK_DIRS_RELEASE )
set(gflags_FRAMEWORKS_RELEASE )
set(gflags_BUILD_DIRS_RELEASE )
set(gflags_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(gflags_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${gflags_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${gflags_COMPILE_OPTIONS_C_RELEASE}>")
set(gflags_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${gflags_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${gflags_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${gflags_EXE_LINK_FLAGS_RELEASE}>")


set(gflags_COMPONENTS_RELEASE )