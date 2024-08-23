module;
import stl;

export module expected;


export namespace fast::util {
    // 定义一个概念，用于限制错误类型
    template<typename E>
    concept ErrorType = std::is_same_v<E, std::string>
                        || std::is_same_v<E, char>
                        || std::is_same_v<E, std::string_view>;


    // 期望类型
    template<typename T, typename E>
        requires ErrorType<E> // 仅当 E 是允许的错误类型时才会实例化
    class expected {
    public:
        // 构造函数：成功时
        expected(T value) : data_(value) {
        }

        // 构造函数：失败时
        expected(E error) : data_(error) {
        }

        // 检查是否有值
        bool has_value() const {
            return std::holds_alternative<T>(data_);
        }

        // 检查是否有错误
        bool has_error() const {
            return std::holds_alternative<E>(data_);
        }

        // 获取值
        T value() const {
            if (has_error()) {
                throw std::runtime_error("Attempted to access value when there is an error.");
            }
            return std::get<T>(data_);
        }

        // 获取错误
        E error() const {
            if (has_value()) {
                throw std::runtime_error("Attempted to access error when there is a value.");
            }
            return std::get<E>(data_);
        }

        // 操作符重载：用于 if 判断
        explicit operator bool() const {
            return has_value();
        }

    private:
        std::variant<T, E> data_; // 存储值或错误
    };

    // 工厂函数：用于创建 Expected 类型对象
    template<typename T, typename E>
        requires ErrorType<E>
    expected<T, E> make_expected(T value) {
        return expected<T, E>(value);
    }

    template<typename T, typename E>
        requires ErrorType<E>
    expected<T, E> make_expected(E error) {
        return expected<T, E>(error);
    }


#if _test_expected


    // 测试用例
    int main() {
        // 成功案例
        expected<int, std::string> success(42);
        if (success.has_value()) {
            std::cout << "Success value: " << success.value() << std::endl;
        } else {
            std::cout << "Error: " << success.error() << std::endl;
        }

        // 失败案例
        expected<int, std::string> failure("Something went wrong");
        if (failure.has_error()) {
            std::cout << "Error: " << failure.error() << std::endl;
        } else {
            std::cout << "Success value: " << failure.value() << std::endl;
        }

        return 0;
    }

#endif
}
