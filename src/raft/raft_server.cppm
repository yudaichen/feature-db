module;


import stl;
import expected;
import packet;
#include "utils/asio_warp.hpp"

export module raft_service;

export namespace fast::raft {
    using namespace boost;

    class RaftServer {
    public:
        RaftServer(asio::io_context &io_context, const std::string &host, unsigned short port)
            : io_context_(io_context),
              socket_(io_context),
              timer_(io_context),
              resolver_(io_context),
              endpoint_(asio::ip::make_address(host), port) {
        }

        // 启动连接
        asio::awaitable<void> start() {
            co_await connect();
            co_await send_heartbeat();
        }

    private:
        asio::io_context &      io_context_;
        asio::ip::tcp::socket   socket_;
        asio::steady_timer      timer_;
        asio::ip::tcp::resolver resolver_;
        asio::ip::tcp::endpoint endpoint_;

        // 连接到服务器
        asio::awaitable<void> connect() {
            auto endpoints = co_await resolver_.async_resolve(endpoint_.address().to_string(),
                                                              std::to_string(endpoint_.port()),
                                                              asio::use_awaitable);
            co_await asio::async_connect(socket_, endpoints, asio::use_awaitable);
            std::cout << "Connected to " << endpoint_.address().to_string() << ":" << endpoint_.port() << std::endl;
        }

        // 定时发送心跳
        asio::awaitable<void> send_heartbeat() {
            while (true) {
                std::string heartbeat = "HEARTBEAT";
                co_await asio::async_write(socket_, asio::buffer(heartbeat), asio::use_awaitable);

                std::cout << "Heartbeat sent." << std::endl;

                using namespace std::chrono_literals;
                timer_.expires_after(5s); // 每 5 秒发送一次心跳
                co_await timer_.async_wait(asio::use_awaitable);
            }
        }

        int run() {
            try {
                asio::io_context io_context;

                // 假设这是集群中其他节点的地址
                std::vector<std::string> other_nodes = {"127.0.0.1:8081", "127.0.0.1:8082"};

                // 使用协程启动 Raft 节点
                co_spawn(io_context, start(), detached);
                io_context.run();
            } catch (const std::exception &e) {
                std::cerr << "Exception: " << e.what() << std::endl;
            }

            return 0;
        }
    };
}
