#pragma once
#ifndef LIST_HPP
#define LIST_HPP

#include "TMPStudy.hpp"
#include "TMPUtils.hpp"
#include <iostream>
#include "BaseInfo.hpp"

namespace TMP {
	template<int N, typename Next>
	struct LIST
	{
		enum { item = N };
		using next = Next;
	};

	template<typename List>
	struct LENGTH
	{
		enum { RET = 1 + LENGTH<typename List::next>::RET };
	};
	template<>
	struct LENGTH<Nul>
	{
		enum { RET = 0 };
	};

	template<typename List, int N>
	struct PUSHFRONT
	{
		using RET = LIST<N, List>;
	};

	template<typename List, int N>
	struct PUSHBACK
	{
	};


	template<typename List>
	struct SHOWLIST
	{
		using next = SHOWLIST<typename List::next>;
		enum { cond = !is_same_type(typename List::next(), Nul()) };
		static void run()
		{
			std::cout << List::item << std::endl;
		}
	};
}

#endif