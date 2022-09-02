#ifndef TMPSTUDY__HPP
#define TMPSTUDY__HPP

#include <iostream>
#include <string>

// declaration value
// enum { value = 1 }
// static const int value = N * Fac<N -1>::value;
// static constexpr auto value = N * Fac<N -1>::value;

// static inline
// if pass by ref	compiler will alloc memory for static member
// isn't compute only in compile time
// C++17 use inline member to solve
// static inline constexpr auto value = N * Fac<N -1>::value;
//����к���f(const int& x)����A����A�ڶ�����static const int i = 1
//���ں����������������ͣ�����f(A::i)Ҫ��ODR-use A::i��
//��ODR-useҪ�����ⶨ�徲̬���ݳ�Ա����������ĵ����ǲ������ġ�
//C++17�����inline������������һ�ζ���
//��˾ͽ����������⣬Ҳ����˵����������ڶ����Ϊ
//static inline const int i = 1�Ϳ��Ե���f(A::i)��
//constexpr�ᱻ��ʽinline������ʡ��
//д������Ϊ��˵��C++17������inline������


//MetaProgramming Constructs
//Conditionals with partial template specialization ƫ�ػ�
//Loops with recursive template definitions ģ��չ�� lisp
//Returns using typedefs


// value metaprogramming
template<int N, int LO = 1, int HI = N>
struct Sqrt
{
	static inline constexpr auto mid = (LO + HI + 1) / 2;
	static inline constexpr auto value =
		(N < mid * mid) ?
		Sqrt<N, LO, mid - 1>::value
		:
		Sqrt<N, mid, HI>::value;
};
template<int N, int M>
struct Sqrt<N, M, M> // termination condition is LO == HI
{
	static inline constexpr auto value = M;
};

// use constexpr function instead of TMP
template<typename T>
constexpr T sqrt(T x)
{
	if constexpr (x <= 1) return x;
	T lo = 0, hi = x;
	while (true)
	{
		auto mid = (hi + lo) / 2, midSquared = mid * mid;
		if constexpr (lo + 1 >= hi || midSquared == x)
		{
			return mid;
		}
		if constexpr (midSquared < x)
		{
			lo = mid;
		}
		else
		{
			hi = mid;
		}
	}
}

// inherit std::integral_constant<>
template<int N>
class Fac : public std::integral_constant<int, N* Fac<N - 1>::value> {};
template<>
class Fac<0> : public std::integral_constant<int, 1> {};



template<int N, int... args>
class Max;

template<int N>
class Max<N> : public std::integral_constant<int, N> {};

template<int N1, int N2, int... args>
class Max<N1, N2, args...> : public
	std::integral_constant<int, N2 < N1 ?
	Max<N2, args...>::value :
	Max<N1, args...>::value >
{};
// error, because > is recognized as end of parameter 
// template<int N1, int N2, int... args>
// class Max<N1, N2, args...> : public
// 	std::integral_constant<int, N1 > N2 ?
// 	Max<N1, args...>::value :
// 	Max<N2, args...>::value>
// {};

template<typename DstT, typename SrcT> // ��Ҫָ���Ĳ�������ǰ��
DstT c_style_cast(SrcT v)
{
	return (DstT)(v);
}
template<typename T, std::size_t N>
struct array
{
	T data[N];
};

template <int i> class A
{
public:
	void foo(int)
	{
	}
};
template <uint8_t a, typename b, void* c> class B {};
template <bool, void (*a)()> class C {};
template <void (A<3>::* a)(int)> class D {};

template <int i> int Add(int a)	// ��ȻҲ�����ں���ģ��
{
	return a + i;
}

template<typename T>
class TypeToID
{
public:
	static const int ID = -1;
};
template<>
class TypeToID<int>
{
public:
	static const int ID = 1234;
};
template<>
class TypeToID<void*>
{
public:
	static const int ID = 1000;
};
template<typename T>
class TypeToID<T*>
{
public:
	static const int ID = 9999;
};
void foo()
{
	A<5> a;
	B<7, A<5>, nullptr>	b;
	C<false, & foo> c; // bool func
	D<&A<3>::foo> d; // member func pointer
	int x = Add<3>(5);

	std::cout << "ID is " << TypeToID<int>::ID << std::endl;
}



// template arr
template<typename T, int N>
void arrayFunc(T(&arr)[N]);

struct TrueType {};
struct FalseType {};

template<typename T>
struct Traits
{
	static const int N1 = 1;
	static const int N2 = 2;
	static const int N3 = 3;
};
template<>
struct Traits<int>
{
	static const int N1 = 11;
};




//template<typename T>
struct Car
{
	enum Info { A, B, C};
};
struct NewCar : Car
{
	enum {
		D = B
	};
};
template<typename T>
struct Car_Traits
{
	using IA = FalseType;
	using IB = FalseType;
};
// �����ػ���ֱ��ΪFalse
// std::is_convertible<T, Car>::value
template<>
struct Car_Traits<NewCar>
{
	using IA = TrueType;
	using IB = FalseType;
};


// compute
template<int N>
struct Fib
{
	enum { Result = Fib<N - 1>::Result + Fib<N - 2>::Result };
};
template<>
struct Fib<0>
{
	enum { Result = 0 };
};
template<>
struct Fib<1>
{
	enum { Result = 1 };
};

template<int N>
struct Fact
{
	enum { Result = N * Fact<N - 1>::Result};
};
template<>
struct Fact<1>
{
	enum { Result = 1 };
};

template<int p, int i>
struct is_prime
{
	enum { prim = (p % i) && is_prime<p, i - 1>::prim };
};
template<int p>
struct is_prime<p, 1>
{
	enum { prim = 1 };
};

struct ControlPolicy
{
	static const int priority = 1;
	void set() 
	{
		std::cout << "policy set" << std::endl;
	}
};
struct UpControl : ControlPolicy
{
	static const int priority = 1;
	void set()
	{
		std::cout << "Up control set" << std::endl;;
	}
};
struct DonwControl : ControlPolicy
{
	static const int priority = 2;
	void set()
	{
		std::cout << "Down control set" << std::endl;;
	}
};
//IF<(1 + 2 > 1), int, long>::RET i;
//IF < (UpControl::priority > DonwControl::priority), UpControl, DonwControl >::RET control;
//control.set();



//template<typename T1, typename T2>
//struct Max
//{
//	enum { RET = (T1::value > T2::value) ? T1::value : T2::value};
//};

template<int n1, int n2>
struct MaxV
{
	enum { RET = (n1 > n2) ? n1 : n2 };
};





// Unrolling չ��
template<int N>
inline void addVal(int* a, int* b, int* c)
{
	*c = *a + *b;
	addVal<N - 1>(a + 1, b + 1, c + 1);
}

template<>
inline void addVal<0>(int* a, int* b, int* c) { }



// static polymorphism ???
template<typename T>
struct Base
{
	void interface()  // what??
	{ 
		static_cast<T*>(this)->implementation();
	}

	static void static_func()
	{
		T::static_sub_func();
	}
};

struct Derived : Base<Derived>
{
	void implementation();
	static void static_sub_func();
};

// clone method ???
class Shape
{
public:
	virtual ~Shape() {};
	virtual Shape* clone() const = 0;
};

template<typename Derived>
class Clonable : public Shape
{
public:
	virtual Shape* clone() const
	{
		return new Derived(static_cast<Derived const&>(*this));
	}
};
class Square : public Clonable<Square> {};
class Circle : public Clonable<Circle> {};

// Eigen Matrix Addition
//template<typename T1, typename T2, typename T3>
//struct CwiseBinaryOp
//{
//
//};
//class VectofXf {};
//template<typename T>
//struct MatrixBase {};
//template<>
//struct MatrixBase<VectorXf>
//{
//	const CwiseBinaryOp < internal::scalar_sum_op < float >, VectorXf, VextorXf>
//		operator+(const MatrixBase<VectorXf>& other) const;
//};
// this too returns an expression

// u = v + w
//applies
//template<typename OtherDerived>
//inline Matrix& operator=(const MatrixBase<OtherDerived>& other)
//{
//	return Base::operator=(other.derived());
//}

//which boils down to calling
//VectorXf& MatrixBase<VectorXf>::operator=(const 
//	MatrixBase<CwiseBinaryOp<
//	internal::scalar_sum_op<float>,
//	VectorXf, VectorXf>>& other)

//template<typename Derived>
//template<typename OtherDerived>
//inline Derived& MatrixBase<Derived>
//::operator=(const MatrixBase<OtherDerived>& other)
//{
//	return internal::assign_selector<Derived, OtherDerived>::run(derived(), other.derived());
//}

//template<typename Derived1, typename Derived2>
//struct internal::assign_impl<Derived1, Derived2, LinearVectorization, NoUnrolling>
//{
//	static void run(Derived1& dst, const Derived2& src)
//	{
//		const int size = dst.size();
//		const int packetSize = 3;
//		const int alignedStart = 4;
//		const int alignedEnd = alignedStart + ((size - alignedStart) / packetSize) * packetSize;
//		for (int index = alignedStart; index < alignedEnd; index += packetSize)
//		{
//			dst.template copyPacket<Derived2, Aligned,
//				internal::assign_traits<Derived1, Derived2>::SrcAlignment>(index, src);
//		}
//		for (int index = alignedEnd; index < size; index++)
//			dst.copyCoeff(index, src);
//	}
//};
#endif