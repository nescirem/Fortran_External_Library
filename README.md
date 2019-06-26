# Fortran External Dynamic & Static Linking  Library

![](https://img.shields.io/badge/platform-linux%20|%20windows-lightgrey.svg) ![](https://img.shields.io/badge/license-MIT-blue.svg)

Compile and the usage of third party static library & dynamic library. [[中文](./README_cn.md)]



## Build

### Windows

open `lib.sln` or `dll.sln` with visual studio (>2013)  which is located in `.\fortran_{Type_of_library}\{Type_of_library}\msvs\` :

**Build - Batch Build - Select all - Build**

then similar operations with `public_code.sln` which is located in `.\fortran_{Type_of_library}\public_solution\msvs\` 

the binary file is located in `.\public_solution\binary\`

### Linux

Intel fortran and GNU fortran is supported.

```bash
./fortran_dynamic_library/build.sh
./fortran_static_library/build.sh
```

or you can specify compiler and debug mode like this:

```bash
./fortran_dynamic_library/build.sh ifort release
./fortran_static_library/build.sh gfortran debug
```

Remember to clean:

```bash
./fortran_dynamic_library/clean_all.sh
./fortran_static_library/clean_all.sh
```



## License

All codes are released under [MIT](./LICENSE) license except `make_depends_tree.sh` in `./tools`



## Thanks to

[[pirpyn](https://github.com/pirpyn)]:  [Fortran-Project-Template](https://github.com/pirpyn/Fortran-Project-Template)

