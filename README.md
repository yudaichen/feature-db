# drongon需要安装
sudo apt-get install libmysqlclient-dev
sudo apt install libmariadb-dev-compat

## 构建完成后 ubuntu22.04 hiredis 0.14与cmake 3.28不兼容，手动修改

### drongon Cmakelist.cmake

    if (BUILD_REDIS)
    find_package(Hiredis)
    if (Hiredis_FOUND)
    message(STATUS "Hiredis found: YES")
    message(STATUS "Hiredis include dirs: ${HIREDIS_INCLUDE_DIRS}")
    message(STATUS "Hiredis libraries: ${HIREDIS_LIBRARIES}")
    message(STATUS "Hiredis version: ${HIREDIS_VERSION}")
    message("redis lib: ${Hiredis_lib}")
    add_definitions(-DUSE_REDIS)
    target_link_libraries(${PROJECT_NAME} PRIVATE ${HIREDIS_LIBRARIES})
    set(DROGON_SOURCES
    ${DROGON_SOURCES}
    nosql_lib/redis/src/RedisClientImpl.cc
    nosql_lib/redis/src/RedisClientLockFree.cc
    nosql_lib/redis/src/RedisClientManager.cc
    nosql_lib/redis/src/RedisConnection.cc
    nosql_lib/redis/src/RedisResult.cc
    nosql_lib/redis/src/RedisTransactionImpl.cc
    nosql_lib/redis/src/SubscribeContext.cc
    nosql_lib/redis/src/RedisSubscriberImpl.cc)
    set(private_headers
    ${private_headers}
    nosql_lib/redis/src/RedisClientImpl.h
    nosql_lib/redis/src/RedisClientLockFree.h
    nosql_lib/redis/src/RedisConnection.h
    nosql_lib/redis/src/RedisTransactionImpl.h
    nosql_lib/redis/src/SubscribeContext.h
    nosql_lib/redis/src/RedisSubscriberImpl.h)
    else ()
    message(STATUS "redis was not found.")
    endif (Hiredis_FOUND)
    endif (BUILD_REDIS)

### 删除/usr/local/lib/cmake/Drogon/DrogonTargets.cmake  find_dependency(hiredis)
