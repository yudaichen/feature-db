# Load the debug and release variables
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB DATA_FILES "${_DIR}/dbg-macro-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${dbg-macro_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${dbg-macro_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET dbg-macro::dbg-macro)
    add_library(dbg-macro::dbg-macro INTERFACE IMPORTED)
    message(${dbg-macro_MESSAGE_MODE} "Conan: Target declared 'dbg-macro::dbg-macro'")
endif()
# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/dbg-macro-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()