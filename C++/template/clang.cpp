//
//  clang.cpp
//  template
//
//  Created by fusionbolt on 2019/4/18.
//  Copyright © 2019 fusionbolt. All rights reserved.
//

// clang下 unknownType直接报错
template<typename T> struct X {};
template <typename T> struct Y
{
    // X可以查找到原型；
    // X<T>是一个依赖性名称，模板定义阶段并不管X<T>是不是正确的。
    typedef X<T> ReboundType;
    
    // X可以查找到原型；
    // X<T>是一个依赖性名称，X<T>::MemberType也是一个依赖性名称；
    // 所以模板声明时也不会管X模板里面有没有MemberType这回事。
    typedef typename X<T>::MemberType MemberType2;
    
    // UnknownType 不是一个依赖性名称
    // 而且这个名字在当前作用域中不存在，所以直接报错。
    typedef UnknownType MemberType3;
};

// msvc下是暂时不会报错的
//template <typename T> struct X {};
//
//template <typename T> struct Y
//{
//    typedef X<T> ReboundType;                // 类型定义1
//    typedef typename X<T>::MemberType MemberType;    // 类型定义2
//    typedef UnknownType MemberType3;            // 类型定义3
//
//    void foo()
//    {
//        X<T> instance0;
//        typename X<T>::MemberType instance1;
//        WTF instance2
//            大王叫我来巡山 - +&
//    }
//};
