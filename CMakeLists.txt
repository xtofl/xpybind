cmake_minimum_required(VERSION 3.10)
project(xpybind LANGUAGES CXX)

find_package(pybind11 REQUIRED)
pybind11_add_module(xpybind MODULE xpybind.cc)
