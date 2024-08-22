/*#define BOOST_ASIO_HAS_CO_AWAIT*/
#pragma once
#include <filesystem>
#include <thread>

#include <coroutine>
//#include "asio.hpp"
#include <boost/asio.hpp>
#include <boost/asio/co_spawn.hpp>
#include <boost/asio/detached.hpp>
#include <boost/asio/io_context.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/signal_set.hpp>
#include <boost/asio/write.hpp>
#include <boost/asio/io_service.hpp>
#include <boost/asio/awaitable.hpp>
#include <boost/asio/awaitable.hpp>
#include <boost/asio/buffer.hpp>
#include <boost/asio/co_spawn.hpp>
#include <boost/asio/connect.hpp>
#include <boost/asio/detached.hpp>
#include <boost/asio/io_context.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/read.hpp>
#include <boost/asio/signal_set.hpp>
#include <boost/asio/this_coro.hpp>
#include <boost/asio/use_awaitable.hpp>
#include <boost/asio/write.hpp>
#include <iostream>

#include "utils/log.h"
using boost::asio::awaitable;
using boost::asio::co_spawn;
using boost::asio::detached;
using boost::asio::use_awaitable;
using boost::asio::ip::tcp;
namespace this_coro = boost::asio::this_coro;


#if defined(BOOST_ASIO_ENABLE_HANDLER_TRACKING)
# define use_awaitable \
boost::asio::use_awaitable_t(__FILE__, __LINE__, __PRETTY_FUNCTION__)
#endif

using namespace boost;
using namespace boost::asio;


asio::awaitable<void> simplePingClient()
{
    try
    {
        tcp::socket socket(co_await asio::this_coro::executor);

        co_await socket.async_connect(tcp::endpoint(asio::ip::make_address("101.43.58.72"), 6379), asio::use_awaitable);

        std::cout << "Connected to Redis server!" << std::endl;

        {
            std::string command_auth = "*2\r\n$4\r\nAUTH\r\n$9\r\nydc061588\r\n";
            co_await asio::async_write(socket, asio::buffer(command_auth), asio::use_awaitable);

            char reply_auth[1024];
            const std::size_t bytes_transferred_auth = co_await socket.async_read_some(
                asio::buffer(reply_auth), asio::use_awaitable);
            std::cout << "Response from Redis: " << std::string(reply_auth, bytes_transferred_auth) << std::endl;
        }

        {
            // 发送命令到 Redis 服务器
            std::string command = "PING\r\n";
            co_await asio::async_write(socket, asio::buffer(command), asio::use_awaitable);

            // 读取 Redis 服务器的响应
            char reply_ping[1024];
            const std::size_t bytes_transferred_pring = co_await socket.async_read_some(
                asio::buffer(reply_ping), asio::use_awaitable);

            LOG_INFO_R << "Response from Redis: " << std::string(reply_ping, bytes_transferred_pring) << std::endl;
        }


        // 关闭连接
        socket.close();
        std::cout << "Connection closed." << std::endl;
    }
    catch (const std::exception& e)
    {
        std::cerr << "Connection error: " << e.what() << std::endl;
    }
}

/*
asio::awaitable<void> syn_file(string_view path)
{

    std::promise<int> prom;
    auto fut = prom.get_future();
    auto fd = co_await boost::asio::open(path, O_RDONLY);
    prom.set_value(fd);
}
*/
void redis_asio_connect()
{
    {
        try
        {
            boost::asio::io_context io_context(1);

            boost::asio::signal_set signals(io_context, SIGINT, SIGTERM);
            signals.async_wait([&](auto, auto) { io_context.stop(); });

            // 执行协程，并设置了一个callback函数来获取这个协程的返回值
            co_spawn(io_context, simplePingClient(), detached);

            io_context.run();
        }
        catch (std::exception& e)
        {
            std::printf("Exception: %s\n", e.what());
        }
    }
}

/**

@brief 登录

*2\r\n$4\r\nAUTH\r\n$your_password_length\r\nyour_password\r\n
- `*2\r\n` 表示这个消息是一个数组，数组有两个元素。
- `$4\r\nAUTH\r\n` 表示数组的第一个元素是一个长度为 4 的字符串，值为 "AUTH"。
- `$your_password_length\r\nyour_password\r\n` 表示数组的第二个元素是长度为 `your_password_length` 的字符串，值为实际的密码字符串。


 */
