#pragma once
#ifndef MYTEMPLATE_HPP
#define MYTEMPLATE_HPP

#include <type_traits>

namespace sp {
	template<typename T, T v>
	struct integral_constant
	{
		using value_type = T;
		using type = integral_constant;
		static inline constexpr T value = v;

		constexpr operator value_type() const noexcept
		{
			return value;
		}
		constexpr value_type operator()() const noexcept
		{
			return value;
		}
	};
	template<bool B>
	using bool_constant = integral_constant<bool, B>;
	
	struct true_type : bool_constant<true> {};
	struct false_type : bool_constant<false> {};
	
	template<typename T, typename U>
	struct is_same : false_type {};
	template<typename T>
	struct is_same<T, T> : true_type {};
	template<typename T, typename U>
	inline constexpr bool is_same_v = is_same<T, U>::value;

	template<typename T, typename T2 = void>
	struct is_void : is_same<std::decay_t<T>, T2> {}; //decay or rmcv?
	template<typename T, typename T2 = void>
	inline constexpr bool is_void_v = is_void<T, T2>::value;
	
	template<typename T>
	struct is_void_other : false_type {};
	template<>
	struct is_void_other<void> : true_type {}; //CV_OPT void
}


#endif