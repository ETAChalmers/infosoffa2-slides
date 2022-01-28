# include <stdlib.h>
# include <vector>
# include <string>

class Argument {

    public:
        Argument(char shortName, std::string longName, std::string usage, bool hasValue, std::string template_value);
        char shortName;
        std::string longName;
        std::string usage;
        bool hasValue;
        std::string template_value;
        bool specified;
        std::string value;
        std::string to_string();
};

class Parser {
    public:
        Parser(std::string appName, std::string usage);
        std::string appName;
        std::vector<Argument> args;
        Argument* base_arg;
        int parse(int argc, char** argv);
        void printUsage();
        Argument* getArgumentFromLongName(std::string longName);
        Argument* getArgumentFromShortName(char name);
        std::string usage;
    private:
        std::vector<Argument> specifiedArguments;
        std::vector<std::string> specifiedArgumentsValue;
};
