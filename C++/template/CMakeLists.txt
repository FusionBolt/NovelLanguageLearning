cmake_minimum_required(VERSION 3.10)
project(template)

set(CMAKE_CXX_STANDARD 17)

set(SOURCE_FILES main.cpp)

add_executable(template ${SOURCE_FILES} LIST.hpp TMPUtils.hpp FoldExpression.hpp TemplateStudy.hpp MyTemplate.hpp)