# include <stdlib.h>
# include <iostream>
# include <fstream>
# include <vector>
# include <cmath>
# include <string>
# include "ArgumentParser.cpp"

/*
 * Rainbow - A lolcat clone / extension, written in C++
 * 
 * Made by loovjo, jonathan.loov@gmail.com
 * Use however you want, I don't care.
 */

struct color {
    unsigned char r, g, b;
};

int getEscapeCodeNum(color col) {
    if (col.r == 255)
        return 232 + col.b;
    return 16 + 36 * col.r + 6 * col.g + col.b;
}

color rainbow(float n) { // N is between 0 and 3
    n = fmod(n, 3);
    float r = fmax(0, fabs(n - 1.5) - 0.5);
    float g = fmax(0, 1 - fabs(n - 1));
    float b = fmax(0, 1 - fabs(n - 2));
    color col = {(int)(r * 5), (int)(g * 5), (int)(b * 5)};
    return col;
}

color grayscale(float n) { // N is between 0 and 3
    int a = 24 * (1 - pow(sin(n * 5) / 2 + 0.5, 0.7));
    color col = {255, 0, a};
    return col;
}

std::string make_col(color col) {
    return "\033[38;5;" + std::to_string(getEscapeCodeNum(col)) + "m";
}

color colorize(float n, int type) {
    if (type == 0)
        return rainbow(n);
    if (type == 1)
        return grayscale(n);
}

int main(int argc, char** argv) {
    
    std::string between_escape_code = "\033[0m";

    float x_change_rate = 0.03;
    float y_change_rate = 0.10;
    std::istream *inputStream;
    std::ifstream fileStream;

    bool final_newline = true;

    int type = 0;

    Parser parser(argv[0], "rainbow - make your text to rainbows");
    parser.args.push_back(Argument('f', "file", "Reads the input from a file", true, "filename"));
    parser.args.push_back(Argument('x', "x-change-rate", "Sets the amount of change in the x direction. Default: " + std::to_string(x_change_rate), true, "num"));
    parser.args.push_back(Argument('y', "y-change-rate", "Sets the amount of change in the y direction. Default: " + std::to_string(y_change_rate), true, "num"));
    parser.args.push_back(Argument('g', "gray", "Makes the text a grayscale instead of a rainbow", false, ""));
    parser.args.push_back(Argument('h', "help", "Displays this help message", false, ""));
    parser.args.push_back(Argument('n', "no-newline", "Suppresses the final newline in the output", false, ""));
    parser.args.push_back(Argument('B', "bold", "Makes the text bold", false, ""));
    parser.args.push_back(Argument('D', "dim", "Makes the text dim", false, ""));
    parser.args.push_back(Argument('I', "inverted", "Makes the text inverted", false, ""));
    parser.args.push_back(Argument('U', "underlined", "Makes the text underlined", false, ""));
    parser.args.push_back(Argument('E', "escape-code", "Sets the escape code to use to every character", false, ""));

    parser.base_arg = parser.getArgumentFromLongName("file");
    
    int status = parser.parse(argc, argv);
    if (status != 0)
        return status;

    if (parser.getArgumentFromShortName('h')->specified) {
        parser.printUsage();
        return 1;
    }
    if (parser.getArgumentFromShortName('x')->specified) {
        std::string value = parser.getArgumentFromShortName('x')->value;
        x_change_rate = std::atof(value.c_str());
    }
    if (parser.getArgumentFromShortName('y')->specified) {
        std::string value = parser.getArgumentFromShortName('y')->value;
        y_change_rate = std::atof(value.c_str());
    }
    if (parser.getArgumentFromShortName('g')->specified) {
        type = 1;
    }
    if (parser.getArgumentFromShortName('f')->specified) {
        std::string fileName = parser.getArgumentFromShortName('f')->value;
        fileStream.open(fileName);
        if (!fileStream.good()) {
            std::cerr << "File " << fileName << " not found" << std::endl;
            return 1;
        }

        inputStream = &fileStream;
    } else
        inputStream = &std::cin;
    if (parser.getArgumentFromShortName('n')->specified) {
        final_newline = false;
    }
    if (parser.getArgumentFromShortName('B')->specified) {
        between_escape_code += "\033[1m";
    }
    if (parser.getArgumentFromShortName('D')->specified) {
        between_escape_code += "\033[2m";
    }
    if (parser.getArgumentFromShortName('I')->specified) {
        between_escape_code += "\033[7m";
    }
    if (parser.getArgumentFromShortName('E')->specified) {
        between_escape_code += parser.getArgumentFromShortName('E')->value;
    }
    *inputStream >> std::noskipws;
    
    int x = 0;
    int y = 0;
    std::string last_escape_code = "";

    for (char ch; (*inputStream) >> ch; ) {
        if (ch == '\n') {
            y++;
            x = 0;
            std::cout << "\033[0m" << std::endl;
            last_escape_code = "";
            continue;
        }
        else
            x++;
        float n = ((float)x * x_change_rate);
        std::string escape_code = make_col(colorize(x * x_change_rate + y * y_change_rate, type));
        if (escape_code == last_escape_code) {
            std::cout << ch;
        }
        else {
            std::cout << between_escape_code << escape_code << ch;
        }
        last_escape_code = escape_code;
    }
    std::cout << "\033[0m";
    if (final_newline)
        std::cout << std::endl;
    return 0;
}
