#pragma once
#ifndef TMPUTILS_HPP
#define TMPUTILS_HPP

#include "BaseInfo.hpp"

namespace TMP {
	// is same type
	template<typename T1, typename T2>
	constexpr bool is_same_type(T1, T2)
	{
		return false;
	}
	template<typename T>
	constexpr bool is_same_type(T, T)
	{
		return true;
	}
	template<typename T1, typename T2>
	struct is_same
	{
		enum { value = 0 };
	};
	template<typename T>
	struct is_same<T, T>
	{
		enum { value = 1 };
	};
	template<typename T1, typename T2>
	inline constexpr bool is_same_v = is_same<T1, T2>::value;

	// Meta fo If
	template<bool condition, typename Then, typename Else>
	struct IF {
		using RET = Then;
	};

	template<typename Then, typename Else>
	struct IF<false, Then, Else> {
		using RET = Else;
	};


	// Meta for Loop
	template<int n, typename Body>
	struct UNROLL
	{
		static void iterator(int i)
		{
			Body::body(i);
			UNROLL<n - 1, Body>::iteration(i + 1);
		}
	};
	template<typename Body>
	struct UNROLL<0, Body>
	{
		static void iteration(int i) { }
	};
	template<int n, typename B>
	struct FOR
	{
		static void loop()
		{
			UNROLL<n, B>::iteration(0);
		}
	};


	// Meta for while

	//template<template<typename>class Condition, typename Statement>
	//struct WHILE
	//{
	//	template<typename Statement>
	//	struct STOP
	//	{
	//		using RET = Statement;
	//	};
	//	using RET = IF<Condition<Statement>::RET,
	//		WHILE<Condition, typename Statement::NExt>,
	//		STOP<Statement>::RET::RET>;
	//};

	template<bool is_True, typename Statement>
	struct WHILE
	{
		static void run()
		{
			Statement::run();
			IF<Statement::cond, WHILE<Statement::cond, typename Statement::next>,
				WHILE<false, Statement>>::RET::run();
		}
	};
	template<typename Statement>
	struct WHILE<false, Statement>
	{
		static void run() { }
	};
}

#endif