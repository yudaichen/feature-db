########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(dbg-macro_COMPONENT_NAMES "")
set(dbg-macro_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(dbg-macro_PACKAGE_FOLDER_RELEASE "/home/ydc/.conan2/p/dbg-mf7ad4338afcd6/p")
set(dbg-macro_BUILD_MODULES_PATHS_RELEASE )


set(dbg-macro_INCLUDE_DIRS_RELEASE "${dbg-macro_PACKAGE_FOLDER_RELEASE}/include")
set(dbg-macro_RES_DIRS_RELEASE )
set(dbg-macro_DEFINITIONS_RELEASE )
set(dbg-macro_SHARED_LINK_FLAGS_RELEASE )
set(dbg-macro_EXE_LINK_FLAGS_RELEASE )
set(dbg-macro_OBJECTS_RELEASE )
set(dbg-macro_COMPILE_DEFINITIONS_RELEASE )
set(dbg-macro_COMPILE_OPTIONS_C_RELEASE )
set(dbg-macro_COMPILE_OPTIONS_CXX_RELEASE )
set(dbg-macro_LIB_DIRS_RELEASE )
set(dbg-macro_BIN_DIRS_RELEASE )
set(dbg-macro_LIBRARY_TYPE_RELEASE UNKNOWN)
set(dbg-macro_IS_HOST_WINDOWS_RELEASE 0)
set(dbg-macro_LIBS_RELEASE )
set(dbg-macro_SYSTEM_LIBS_RELEASE )
set(dbg-macro_FRAMEWORK_DIRS_RELEASE )
set(dbg-macro_FRAMEWORKS_RELEASE )
set(dbg-macro_BUILD_DIRS_RELEASE )
set(dbg-macro_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(dbg-macro_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${dbg-macro_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${dbg-macro_COMPILE_OPTIONS_C_RELEASE}>")
set(dbg-macro_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${dbg-macro_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${dbg-macro_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${dbg-macro_EXE_LINK_FLAGS_RELEASE}>")


set(dbg-macro_COMPONENTS_RELEASE )