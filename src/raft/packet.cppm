module;


import stl;
import expected;
#include "yaml-cpp/yaml.h"

export module packet;

export namespace fast::raft {
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
        std::string id;   //端口号
    };

    // 从 YAML 节点中加载 Node 对象
    inline void loadNode(const YAML::Node &node, RaftNodeConfig &result) {
        result.ip = node["ip"].as<std::string>();
        result.ip = node["port"].as<std::string>();
        result.id = node["id"].as<std::string>();
    }

    fast::util::expected<std::vector<RaftNodeConfig>, std::string> GetRaftNodeConfig(const std::string &fileName) {
        YAML::Node config = YAML::LoadFile(fileName);
        if (!config) {
            return {"Open config File:" + fileName + " failed."};
        }

        // 读取config
        try {
            const auto &                raftNodes = config["server"]["raft"];
            std::vector<RaftNodeConfig> result;
            for (const auto &raftNode: raftNodes) {
                RaftNodeConfig configNode;
                loadNode(raftNode["node"], configNode);
                result.push_back(configNode);
            }
            return result;
        } catch (const YAML::Exception &e) {
            return {std::string("Error parsing YAML file: ") + e.what()};
        }
    }
}
