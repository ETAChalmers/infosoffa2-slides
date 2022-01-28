#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <vector>
#include "ArgumentParser.hpp"

# define IS_TESTING false

/*
 * A very simple library to parse command line arguments. Made by loovjo (jonathan.loov@gmail.com)
 */

Argument::Argument(char shortName, std::string longName, std::string usage, bool hasValue, std::string template_value) {
    this->shortName      = shortName;
    this->longName       = longName;
    this->usage          = usage;
    this->hasValue       = hasValue;
    this->template_value = template_value;
    this->specified = false;
}
std::string Argument::to_string() {
    std::string result = "Argument(sn='";
    result += std::string(1, shortName);
    result += "', ln=\"";
    result += longName;
    result += "\", ";
    if (hasValue) {
        result += "tmplt_val=\"";
        result += template_value;
        result += "\", ";
    }
    else {
        result += "has_value=false, ";
    }
    result += "specified=";
    result += (specified ? "true" : "false");
    if (specified && hasValue) {
        result += ", value=\"";
        result += value;
        result += "\"";
    }
    return result + ")";
}

int Parser::parse(int argc, char** argv) {
    std::vector<std::string> args;
    for (int i = 1; i < argc; i++) {
        args.push_back(std::string(argv[i]));
    }

    Argument* last = base_arg;
    for (int i = 0; i < args.size(); i++) {
        std::string arg = args[i];
        bool error = false;
        if (arg[0] == '-') {
            if (arg[1] != '-') {
                for (int j = 1; j < arg.length(); j++) {
                    last = getArgumentFromShortName(arg[j]);
                    if (last == NULL) {
                        std::cerr << "Unknown option -" << arg[j] << std::endl;

                        for (int j = 0; j < argc; j++) {
                            std::cout << argv[j] << " ";
                        }
                        std::cout << std::endl;
                        for (int count = 0; count <= std::string(argv[0]).length(); count++)
                            std::cout << " ";
                        for (int k = 0; k < args.size(); k++) {
                            if (k != i) {
                                for (int count = 0; count <= args[k].length(); count++)
                                    std::cout << " ";
                            }
                            else {
                                for (int count = 0; count < j; count++)
                                    std::cout << " ";
                                std::cout << "^" << std::endl;
                                break;
                            }
                        }
                        return 1;
                    }
                    else {
                        last->specified = true;
                    }
                }
            }
            else {
                std::string argName;
                for (int j = 2; j < arg.length(); j++) {
                    argName += arg[j];
                }
                last = getArgumentFromLongName(argName);
                if (last == NULL) {
                    std::cerr << "Error: Unknown option --" << argName << std::endl;
                    error = true;
                }
                else {
                    last->specified = true;
                }
            }
        }
        else {
            if (last != NULL && last->hasValue) {
                if (last->value == "")
                    last->value = args[i];
                else
                    last->value += " " + args[i];
                last->specified = true;
                last = base_arg;
            }
            else if (last != NULL) {
                std::cerr << "Error: Option -" << last->shortName << " (--" << last->longName << ") doesn't take any parameters." << std::endl;
                error = true;
            }
            else {
                std::cerr << "Error: No option specified for parameter " << std::endl;
                error = true;
            }
        }
        if (error) {
            for (int j = 0; j < argc; j++) {
                std::cout << argv[j] << " ";
            }
            std::cout << std::endl;
            for (int count = 0; count <= std::string(argv[0]).length(); count++)
                std::cout << " ";
            for (int j = 0; j < args.size(); j++) {
                char rep = ' ';
                if (j == i)
                    rep = '^';
                for (int k = 0; k < args[j].length(); k++) {
                    std::cout << rep;
                }
                std::cout << " ";
            }
            std::cout << std::endl;
            return 1;
        }
    }
    return 0;
}
Parser::Parser(std::string appName, std::string usage) {
    this->appName = appName;
    this->usage = usage;
}
Argument* Parser::getArgumentFromLongName(std::string name) {
    for (int i = 0; i < args.size(); i++) {
        if (args[i].longName == name) {
            return &args[i];
        }
    }
    return NULL;
}
Argument* Parser::getArgumentFromShortName(char name) {
    for (int i = 0; i < args.size(); i++) {
        if (args[i].shortName == name) {
            return &args[i];
        }
    }
    return NULL;
}

void Parser::printUsage() {
    std::cout << "Usage: " << appName << " ";
    for (int i = 0; i < args.size(); i++) {
        std::cout << "[-" << args[i].shortName;
        if (args[i].hasValue) {
            std::cout << " " << args[i].template_value;
        }
        std::cout << "] ";
    }
    std::cout << std::endl;
    std::cout << usage << std::endl;
    for (int i = 0; i < args.size(); i++) {
        std::cout << "\t-" << args[i].shortName << "/--" << args[i].longName << ": " << args[i].usage << std::endl;
    }
}

# if IS_TESTING

int main(int argc, char** argv) {
    Parser parser(std::string(argv[0]), "testapp is a test for the ArgumentParser");
    parser.args.push_back(Argument('c', "color", "Sets the color to use", true, "color"));
    parser.args.push_back(Argument('a', "ascii", "Enables ASCII-support", false, ""));
    parser.args.push_back(Argument('h', "help", "Displays this help message", false, ""));
    parser.base_arg = parser.getArgumentFromShortName('c');

    char* argv_[4];
    argv_[0] = "./a.out";
    argv_[1] = "red";
    argv_[2] = "-a";
    argv_[3] = "--help";
    int status = parser.parse(4, argv_);
    if (status != 0)
        return status;
    
    if (parser.getArgumentFromShortName('h')->specified)
        parser.printUsage();
    if (parser.getArgumentFromShortName('c')->specified)
        std::cout << "Specified color: " << parser.getArgumentFromShortName('c')->value << std::endl;
    if (parser.getArgumentFromShortName('a')->specified)
        std::cout << "Ascii mode enabled" << std::endl;

    for (int a = 0; a < parser.args.size(); a++) {
        std::cout << parser.args[a].to_string() << std::endl;
    }
}

# endif
