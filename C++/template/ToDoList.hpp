// 1.
//Ϊʲô�Ǵ��
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

// 2.ģ��ֻ�������β����Ǹ�����

// 3.��һ��while

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

// 5.��дwhile

// 6.�淶����ʽ, ���� �ο�ppt,ģ��������ʽ �����Ƿ�Ҫ�����ƿռ�::

// 7.TMP Question and note

// 8.inline template

// 9.is_same_type