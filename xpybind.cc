#include "pybind11/pybind11.h"


auto simple_method(int a, int b){
    return a+b;
}

PYBIND11_MODULE(xpybind, m) {
    m.doc() = "xpybind example plugin";
    m.def("simple_method", &simple_method, "A function that adds two numbers");
}
