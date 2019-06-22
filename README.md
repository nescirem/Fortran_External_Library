# Fortran Dynamic Linking & Static Linking

Compile and the usage of static library & dynamic library in Visual Studio + Intel Visual Fortran. [[中文](./README_cn.md)]

***

## Build

find and open `lib.sln` or `dll.sln` with visual studio (>2015)  which is located in `.\fortran_{Type_of_library}\{Type_of_library}\msvs\` :

**Build - Batch Build - Select all - Build**

then find and open `public_code.sln` with visual studio (>2015)  which is located in `.\fortran_{Type_of_library}\public_solution\msvs\` :

**Build - Batch Build - Select all - Build**

the binary file is located in `.\public_solution\binary\`
