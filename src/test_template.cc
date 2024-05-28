#include <iostream>
#include <type_traits>


template <typename ...Args>
struct Sum;

template <typename First, typename... Res>
struct Sum<First, Res...>  : public std::integral_constant<int, Sum<First>::value + Sum<Res...>::value> {};

template <typename Last>
struct  Sum<Last> : public std::integral_constant<int ,sizeof(Last)> {};

template <typename... Args, typename T>
void func(Sum<Args...> sum, T val)
{
    std::cout << Sum<Args...>::value << std::endl;
}

int main()
{
    func(Sum<int, int, int>(), 3);
    return 0;
}