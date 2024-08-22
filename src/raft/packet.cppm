module;


import stl;
#include "yaml-cpp/yaml.h"

export module packet;

namespace fast::raft {
    // 日志
    struct Log {
        int         index     = -1;    // 日志记录的索引
        int         term      = 0;     // 日志记录的任期
        bool        is_server = false; // 是否是服务器自己的日志
        std::string content;           // 内容
    };

    // 身份
    enum class State {
        None      = 0,
        Leader    = 1, // 领导
        Candidate = 2, // 候选人
        Follower  = 3, // 跟随者
    };

    // 请求投票
    struct VoteArgs // 参数
    {
        int term           = 0;  // 候选人的任期
        int candidate_id   = 0;  // 候选人的id
        int last_log_index = -1; // 候选人最新log的index
        int last_log_term  = 0;  // 候选人最新log的任期
    };

    // 投票的回复
    struct VoteReply {
        int  term         = 0;     // 返回的任期
        bool vote_granted = false; // 是否投票
    };

    // 追加条目（可作心跳）
    struct AppendEntriesArgs {
        int              term          = 0; // 领导的任期
        int              leader_id     = 0; // 领导的id
        int              pre_log_index = 0; // 跟随者的同步进度索引
        int              pre_log_term  = 0; // 跟随者的同步进度任期
        int              commit_index  = 0; // 领导的最新提交索引
        std::vector<Log> log_vec;           // 要同步的日志
    };

    // 追加条目的回复
    struct AppendEntriesReply {
        int  id           = 0;     // 返回的id
        int  term         = 0;     // 返回的任期
        int  log_count    = 0;     // 要同步的日志数量
        bool success      = false; // 是否同步成功
        int  commit_index = 0;     // 返回的最新提交索引
    };

    struct RaftNodeConfig {
        std::string ip;   //ip地址
        std::string port; //端口号
    };

   std::vector<RaftNodeConfig> GetRaftNodeConfig(const std::string& fileName) {
       std::vector<RaftNodeConfig> result;
        /*
        YAML::Node config = YAML::LoadFile(fileName);
        if (!config) {
            std::cout << "Open config File:" << fileName << " failed.";
            return false;
        }
        if (!config["transform"]) {
            std::cout << "Open config File:" << fileName << " has no transform.";
            return nullptr;
        }

        if (config["transform"]["translation"]) {
            // 读取yaml文件中的transform下的translation的x的值
            x_ = config["transform"]["translation"]["x"].as<float>();
        } else {
            std::cout << "config File:" << file_name << " has no transform:translation.";
            return false;
        }
        */

        return result;
    }
}
