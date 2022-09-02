//
// Created by fusionbolt on 2019-05-05.
//

#ifndef TEMPLATE_TEMPLATESTUDY_HPP
#define TEMPLATE_TEMPLATESTUDY_HPP

#include <iostream>
#include <string>
#include <type_traits>
#include <stack>
#include <vector>
#include <bitset>

#include "TMPStudy.hpp"
#include "LIST.hpp"
#include "TMPUtils.hpp"
#include "FoldExpression.hpp"

template<typename T>
void f(T&& t)
{
    t();
}
void fun(){}
//f([](){ cout << "mio" << endl; });
//f(fun);

template<auto Val, typename T = decltype(Val)>
T foo()
{

};
template<typename T, T Val = T{}>
T bar()
{

}

template<typename T>
struct Test
{
    Test(T);
};
Test(char const*) -> Test<std::string>;


template<typename T>
class BaseClass {
public:
    void bar();
};
template<typename T>
class DerivedClass : BaseClass<T> {
public:
    void foo() {
        BaseClass<T>::bar();
        // calls external bar() or error
        // using BaseClass<T>::fun to call  base call()
    }
};

// arr
//template<typename T>
//void f(T(&)[]);
//template<typename T, std::size_t N>
//void f(T(&)[N]);  // P123 19.3.1 401 more info

template<typename T>
class Stack
{
private:
    std::deque<T> elems; // elements
public:
    void push(T const &); // push element
    void pop(); // pop element
    T const &top() const; // return top element
    bool empty() const
    { // return whether the stack is empty
        return elems.empty();
    }

// assign stack of elements of type T2
// can't instead of constructor or assignment operator
    template<typename T2>
    Stack &operator=(Stack<T2> const &rhs)
    {
        elems.clear();
        elems.insert(elems.begin(), rhs.elems.begin(), rhs.elems.end());
        return *this;
    }
// compiler will check convert T T2

// to get access to private members of Stack<T2> for any type T2:
    template<typename> friend
    class Stack;
};



class SomeCompilerSpecificName
{
public:
    SomeCompilerSpecificName();
    template<typename T1, typename T2>
    auto operator()(T1 x, T2 y) const
    {
        return x + y;
    }
};


// template lambda in C++14
auto t = [](auto a, auto b){};


// variable templates since C++14
template<typename T = long double>
constexpr T pi {3.1415926};

template<auto N>
constexpr decltype(N) dval = N;

template<typename T>
struct MyClass
{
    static constexpr int max = 1000;
};
template<typename T>
inline constexpr int myMax = MyClass<T>::max;
auto my_int_max = myMax<int>;


template<typename T>
struct MyC
{
    static constexpr bool is_ok = false;
};
template<typename T>
inline constexpr bool MyC_ok = MyC<T>::is_ok;
auto myc_int_ok = MyC_ok<int>;



template<typename T,
        template<typename Elem, typename = std::allocator<Elem>>
        class Cont = std::deque>
//if don'n have allocator, is error, can't compatible
// isn't std::deque<T>
// is error before C++11
// or class Cont = std::deque
struct St
{
    Cont<T> elems; // is particular to this example
    void push(T const&);
};
template<typename T,
        template<typename Elem, typename = std::allocator<Elem>>
        class Cont>
void St<T,Cont>::push (T const& elem)
{
    elems.push_back(elem); // append copy of passed elem
}
//St<double, std::vector> St;



// construct before the period depends on a template parameter
// P130 / 13.3.3
// before . or -> is template arguments
// s.template call function / s->template call function
template<unsigned int N>
void p(std::bitset<N> const& b)
{
    b.template to_string<char, std::char_traits<char>,
            std::allocator<char>>();
}



struct TTT
{
    TTT&operator=(TTT const&)
    {
        std::cout << "operator TTT const&" << std::endl;
        return *this;
    }

    // can't instead of constructor or assignment operator
    template<typename T>
    TTT& operator=(T const&)
    {
        std::cout << "operator = T const&" << std::endl;
        return *this;
    }
};
//TTT t1, t2;
//t2 = t1;
// operator TTT




class SpecClassFun
{
    template<typename Ty = int>
    Ty get()const{} // const !! distinguish overload
};
template<>
inline bool SpecClassFun::get<bool>()const
{  return true; }
// declare it with inline to avoid error
// if the definition is included by different translation units


#ifdef _MSC_VER
#define TypeName(m) typeid(m).name()
#else
#include <cxxabi.h>
#define TypeName(m) abi::__cxa_demangle(typeid(m).name(), 0, 0, &status)
#endif

int status;
template<typename T>
void tp(T&& t)
{
    std::cout << TypeName(std::forward<T>(t)) << std::endl;
}
// tp("mol");
// char [4]


// type requirement/constraint -> enable_if
// std::enable_if_t<condition, typename T = void>::type
// true -> type ; false -> null -> SFINAE
// define own name for it using an alias template
template<typename T>
using EnableIfString = std::enable_if_t<
        std::is_convertible_v<T, std::string>>;

struct Person
{
private:
    std::string name;
public:
    // Priority match than Person(Person const &p)
    // after add EnableIfString
    // when T isn't convertible to string -> SFINAE -> match other fun
    template<typename T, typename = EnableIfString<T>>
    explicit Person(T&& n): name(std::forward<T>(n))
    {
		std::cout << "TMPL-CONSTR for:" << name << std::endl;
    }
    // const is necessary
    Person(Person const &p):name(p.name)
    {
        std::cout << "COPY-CONSTR Person:" << name << std::endl;
    }
    Person(Person&& p):name(std::move(p.name))
    {
        std::cout << "MOVE-CONSTR Person:" << name << std::endl;
    }
};
//std::string s = "ywwi";
//Person p1(s);
//Person p2("mole");
//Person const p2c("p2c");
//Person p3c(p2c);
//TMPL-CONSTR for ’ywwi’
//TMPL-CONSTR for ’mole’
//TMPL-CONSTR for ’p2c’
//COPY-CONSTR Person ’p2c’

class DCV
{
public:
    DCV(){}
    // const volatile to enable better matches , and error
    // cause other default constructor be deleted
    DCV(DCV const volatile&) = delete;
    // member function templates never count as special member functions
    // and are ignored when
    // so set default constructor be deleted
    // and we can additional constraints
    template<typename T>
    DCV(T const&)
    {
        std::cout << "tmpl copy constructor" << std::endl;
    }
};
//DCV dcv;
//DCV dcvy {dcv};
// call member template



template<typename T>
void outR(T& arg)
{
    static_assert(!std::is_const_v<T>, "out parameter of foo<T>(T&) is const");
    // prevent passed const value
    // or enable_if
}
//int arrt[] = {1,2,3,4};
//int arr[4];
//outR(arrt);
// outR("mol"); because of static_assert , error



template<typename T>
void passR(T&& arg)
{
    T x;
}

template<typename T>
T retR(T&&)
{
    return T{};
    // T maybe a ref, when pass a lvalue ref
    // return a local ref is usually error
}
template<typename T>
auto retV(T)
{
    return T{};
    // if signature is T retV(T)
    // retV<int&> -> T is ref -> error
    // auto -> always decay
    // std::remove_reference_t<T> -> remove ref
}
//int passInt = 4;
//passR(passInt);
// is error, passInt -> int& -> T is int& -> x must init


template<typename T>
void psT(T t)
{
    std::cout << TypeName(t) << std::endl;
}
//int psta = 4;
//psT(std::ref(psta));
// reference_wrapper<int>
// ref via wrapper to value

// TMP
template<unsigned p, unsigned q>
struct DoIsPrime
{
    static constexpr bool value = (p % q != 0) && DoIsPrime<p, q-1>::value;
};
template<unsigned p>
struct DoIsPrime<p, 2>
{
    static constexpr bool value = (p % 2 != 0);
};
template<unsigned p>
struct IsPrime
{
    static constexpr bool value = DoIsPrime<p, p/2>::value;
};
template<>
struct IsPrime<0>
{
    static constexpr bool value = false;
};
template<>
struct IsPrime<1>
{
    static constexpr bool value = false;
};
template<>
struct IsPrime<2>
{
    static constexpr bool value = true;
};
template<>
struct IsPrime<3>
{
    static constexpr bool value = true;
};

// SFINAE
// decltype is an unevaluated operand
// can create “dummy objects” without calling constructors,
template<typename T>
auto len (T const& t) -> decltype( (void)(t.size()),
        T::size_type() )
{
    return t.size();
}

template<typename T>
typename T::size_t len(T const& t)
{
    std::cout << "const" << std::endl;
    return t.size();
}
std::size_t len(...)
{
    std::cout << "..." << std::endl;
    return 0;
}
//std::allocator<int> alloc;
//len(alloc);
// SFINAE match len(...)

// callable object
template<typename Iter, typename Callable, typename... Args>
void foreach(Iter first, Iter last, Callable op, Args const&... args)
{
    while(first != last)
    {
        std::invoke(op, args..., *first);
        ++first;
    }
}

template<typename Callable, typename... Args>
decltype(auto) call(Callable&& op, Args&&... args)
{
    if constexpr (std::is_same_v<
            std::invoke_result_t<Callable, Args...>,
            void>)
    {
        std::invoke(std::forward<Callable>(op),
                    std::forward<Args>(args)...);
    }
    return std::invoke(std::forward<Callable>(op),
                       std::forward<Args>(args)...);
}

template<typename T1, typename T2,
        typename RT = std::decay_t<decltype(true ?
                                            std::declval<T1>()
                                                 :
                                            std::declval<T2>())>>
// RT can't be lvalue ref
// so should use decay
// declval yield rvalue ref
RT max (T1 a, T2 b)
{
    return b < a ? a : b;
}

// get val from fun, process and become arguments
// perfact forward -> auto&&+forward
// typename T t
// auto && = t;
template<typename T>
void set(T) {}
template<typename T>
T get(T) {}
template<typename T>
void PFfoo(T x)
{
    auto && val = get(x);
    // process val
    set(std::forward<decltype(val)>(val));
}

template<typename T>
class TCC
{
    static_assert(!std::is_same_v<std::remove_cv_t<T>, void>);
public:
    template<typename V>
    void f(V&&)
    {
        if constexpr (std::is_reference_v<T>)
        {

        }
        // remove_cv<int const&> yield int const
        // ref is not const, the call has no effect
        // remove_const_t<std::remove_reference_t<int const&>> yield int
        // std::decay_t<int const&> yield int
        if constexpr (std::is_convertible_v<std::decay_t<V>, T>)
        {

        }
        if constexpr (std::has_virtual_destructor_v<V>)
        {

        }
    }
};
template<typename T>
class NotRef
{
    static_assert(std::is_reference_v<T>, "Invalid instantiation for reference");
};

template<typename T>
void tmplParamIsReference(T)
{
    std::cout << "T is reference: " << std::is_reference_v<T> << std::endl;
}
//int templnum = 1;
//int& tmplnum = templnum;
//tmplParamIsReference(tmplnum); // int
//tmplParamIsReference(templnum); // int
//tmplParamIsReference<int&>(tmplnum); // int&
//tmplParamIsReference<int&>(templnum); // int&


template<typename T>
class Cont
{
private:
    T* elems;
public:
    // is_move_constructible requires that its argument is a complete type
    // using member fun , defer to the point of instantiation of foo
    template<typename D = T>
    typename std::conditional_t<
            std::is_move_constructible_v<D>, T&&, T&>
    foo() {};
};
// Node is a complete type; it was only incomplete while being defined
struct SNode
{
    std::string value;
    Cont<SNode> next;
    // only possible if Cont accept incomplete types
};


class DECT
{
public:
    DECT() { std::cout << "decltype call constructor" << std::endl; }
};
// decltype(DECT()) t;
// perform constructor


// std::cout << TypeName(24u) << std::endl; unsigned int
// std::vector v {1,2,3}; C++17


template<typename T1>
struct TestClass
{
    template<typename T2>
    void mem_temp();
};
template<typename T>
template<typename T2>
void TestClass<T>::mem_temp()
{

}

#endif //TEMPLATE_TEMPLATESTUDY_HPP
