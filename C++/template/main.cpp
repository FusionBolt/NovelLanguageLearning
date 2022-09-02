//
//  main.cpp
//  template
//
//  Created by fusionbolt on 2019/4/17.
//  Copyright © 2019 fusionbolt. All rights reserved.
//

#include <iostream>
#include <string>
#include <type_traits>
#include <stack>
#include <vector>

#include "TMPStudy.hpp"
#include "LIST.hpp"
#include "TMPUtils.hpp"
#include "FoldExpression.hpp"
#include "TemplateStudy.hpp"
#include "MyTemplate.hpp"

using std::cout;
using std::endl;
using namespace TMP;

template<typename T>
void TestType(T);
int main(int argc, const char * argv[])
{
	std::cout << Max<1,2,3,4,5>::value << std::endl;
	std::cout << sp::is_void_v<const void> << std::endl; // 1
	std::is_same<int, float> t;
	std::integral_constant<int, 1> s;
	std::cout << s << std::endl;
	std::cout << (s) << std::endl;
	using L = LIST<9, LIST<4, LIST<7, Nul>>>;
	using list = typename PUSHFRONT<L, 8>::RET;
	WHILE<!is_same<list, Nul>::value, SHOWLIST<list>>::run();
	//WHILE<!is_same_type(list(), Nul()), SHOWLIST<list>>::run();
	//using Print = WHILE<!is_same_Type<list, Nul>::value, SHOWLIST<list>>;
	using Print = WHILE<!is_same_v<list, Nul>, SHOWLIST<list>>;
	Print::run();
	//cout << Fib<6>::Result << endl;
	//cout << Fact<5>::Result << endl;
    return 0;
}