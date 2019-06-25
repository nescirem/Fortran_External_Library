# Fortran External Dynamic & Static Linking  Library

Compile and the usage of third party static library & dynamic library. [[中文](./README_cn.md)]



## Build

### Windows

open `lib.sln` or `dll.sln` with visual studio (>2015)  which is located in `.\fortran_{Type_of_library}\{Type_of_library}\msvs\` :

**Build - Batch Build - Select all - Build**

then similar operations with `public_code.sln` which is located in `.\fortran_{Type_of_library}\public_solution\msvs\` 

the binary file is located in `.\public_solution\binary\`

### Linux

Intel fortran and GNU fortran is supported.

```bash
./fortran_dynamic_library/build.sh
./fortran_static_library/build.sh
```



## Thanks to

[[pirpyn](https://github.com/pirpyn)]:  [Fortran-Project-Template](https://github.com/pirpyn/Fortran-Project-Template)

