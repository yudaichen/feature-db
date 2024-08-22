import stl;
import sys_utils;
import queue_utils;
import collect_utils;

#include <gtest/gtest.h>
#include "utils/log.h"

using namespace fast::util;



TEST(LockFreeMap_test, test_utils)
{
    SafeQueue<std::string> safe_queue;

    std::string insertStr = "sadasd";
    safe_queue.enqueue(insertStr);

    LockFreeList<std::string> lock_free_list;
    lock_free_list.insert("One");

    LockFreeMap<int, std::string> lfmap(10);
    lfmap.insert(1, "One");
    lfmap.insert(2, "Two");
    lfmap.insert(3, "Three");

    /*
    // check the fields number
    const Value     *values     = inserts.values.data();
    const int        value_num  = static_cast<int>(inserts.values.size());
    const TableMeta &table_meta = table->table_meta();
    const int        field_num  = table_meta.field_num() - table_meta.sys_field_num();
    */

    std::cout << std::format("Map size: {}",lfmap.size())<< std::endl;

    lfmap.insert(1, "One");
    lfmap.insert(2, "Two");
    lfmap.insert(3, "Three");


    std::cout << "Map size: " << lfmap.size() << std::endl;

    lfmap.remove(2);

    std::cout << "Map size after removal: " << lfmap.size() << std::endl;

    /*lfmap.clear();

    std::cout << "Map size after clear: " << lfmap.size() << std::endl;*/
}
