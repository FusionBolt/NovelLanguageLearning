// 1.
//为什么是错的
//constexpr operator bool()
//template<bool t>
//struct T {};
//template<typename T>
//struct P
//{
//	constexpr operator bool() { return false; }
//};
//using newName = T<P<int>()>;


//template<typename T1, typename T2>
//struct is_same_T
//{
//	constexpr operator bool()
//	{
//		return false;
//	}
//};
//template<typename T>
//struct is_same_T<T, T>
//{
//	constexpr operator bool()
//	{
//		return true;
//	}
//};

// 2.模板只能是整形不能是浮点型

// 3.另一种while

//4. arr
//template<typename T, int N>
//int f(T(&arr)[N])
//{
//
//}
//template<int N>
//int f<char, N>(char(&arr)[N])
//{
//
//}

// 5.重写while

// 6.规范化格式, 命名 参考ppt,模板命名方式 库内是否要用名称空间::

// 7.TMP Question and note

// 8.inline template

// 9.is_same_type