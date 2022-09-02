//
// Created by fusionbolt on 2019-04-29.
//

#ifndef TEMPLATE_FOLDEXPRESSION_HPP
#define TEMPLATE_FOLDEXPRESSION_HPP

#include <iostream>
#include <type_traits>

template<typename T>
void print(T arg)
{
    std::cout << arg << std::endl;
}
template<typename T, typename... Types>
void print(T firstArg, Types... args)
{
    //std::cout << sizeof...(Types) << std::endl;

//    std::cout << firstArg << std::endl;
//    if (sizeof...(args) > 0)
//    if constexpr (sizeof... (args)>0) since C++17
//        (std::cout << ... << args) << endl;

    print(firstArg);
    print(args...);
};
template<typename... T>
void printDoubled (T const&... args)
{
    print (args + args...);
}
// (args + args...) -> a+a  b+b
// (T1, T2, T3) -> (T1+T1, T2+T2, T3+T3)
//printDoubled(std::string("mole"), 55, std::string("mio"));
//molemole
//110
//miomio


template<typename... T>
void addOne (T const&... args)
{
//print (args + 1...); // ERROR: 1… is a literal with too many decimal points
    print (args + 1 ...); // OK
    print ((args + 1)...); // OK
}

template<typename T1, typename... TN>
constexpr bool isHomogeneous (T1, TN...)
{
    return (std::is_same<T1,TN>::value && ...); // since C++17
}

template<typename C, typename... Idx>
void printElems (C const& coll, Idx... idx)
{
    print (coll[idx]...);
}
// printElems(coll 2, 0, 3)
// print(coll[2], coll[0], c0ll[3])

template<std::size_t... Idx, typename C>
void printIdx (C const& coll)
{
    print(coll[Idx]...);
}
//std::vector<std::string> coll = {"good", "times", "say", "bye"};
//printIdx<2,0,3>(coll);

template<std::size_t...>
struct Indices {};
template<typename T, std::size_t... Idx>
void printByIdx(T t, Indices<Idx...>)
{
    print(std::get<Idx>(t)...);
}

template<typename T, std::size_t... Idx>
void printByIdx(T t)
{
    print(std::get<Idx>(t)...);
}
// pbi<decltype(tup), 2,3,1>(tup);
// too complex

//auto tup = std::make_tuple(12, "ywwi", 55, "mol");
//printByIdx(tup, Indices<2, 3, 1>());
//printByIdx<decltype(tup), 2,3,1>(tup);
//output:
//55
//mol
//ywwi
// if use const char* is error     (args + args...) -> a+a  b+b

struct Node {
    int value;
    Node* left;
    Node* right;
    Node(int i=0) : value(i), left(nullptr), right(nullptr) {}
};
auto left = &Node::left;
auto right = &Node::right;
// traverse tree, using fold expression:
// ( init op ... op pack )
template<typename T, typename... TP>
Node* traverse(T np, TP... paths) {
    return (np ->* ... ->* paths); // np ->* paths1 ->* paths2 ...
} // ->* 解引用 二元运算符  ->为一元运算符 折叠表达式必须用二元运算符
// 成员函数指针，访问对应的成员函数
// Node* ->* 成员函数地址 // 通过Node*访问该成员函数
// example:
//Node* root = new Node{0};
//root->left = new Node{1};
//root->left->right = new Node{2};
//Node* node = traverse(root, left, right);


// ( … op pack )
template<typename... T>
auto foldSum(T... s)
{
    return (... + s);
}


class Customer
{
private:
    std::string name;
public:
    Customer(std::string const& n) : name(n) { }
    std::string getName() const { return name; }
};
struct CustomerEq {
    bool operator() (Customer const& c1, Customer const& c2)
    const {
        return c1.getName() == c2.getName();
    }
};
struct CustomerHash {
    std::size_t operator() (Customer const& c) const {
        return std::hash<std::string>()(c.getName());
    }
};
// define class that combines operator() for variadic base classes
template<typename... Bases>
struct Overloader : Bases...
{
    using Bases::operator()...; // OK since C++17
};


void testfun(int a, int b){}
void othertestfun(int a){}
template<typename ... Args>
void foldfunction(Args&&... args)
{
    testfun(othertestfun(std::forward<Args>(args))...);
}

#endif //TEMPLATE_FOLDEXPRESSION_HPP
