# Fortran External Dynamic & Static Linking  Library

![](https://img.shields.io/badge/platform-linux%20|%20windows-lightgrey.svg) ![](https://img.shields.io/badge/license-MIT-blue.svg)

Compile and the usage of third-party Fortran static library & dynamic library. [[中文](./README_cn.md)]



## Links

* Source code repository: https://github.com/nescirem/Fortran_External_Library



## Build

### Windows

open `lib.sln` or `dll.sln` with visual studio (>2010 sp1)  which is located in `.\{language}_{Type_of_library}\{Type_of_library}\msvs\` :

**Build - Batch Build - Select all - Build**

then similar operations with `public_code.sln` which is located in `.\{language}_{Type_of_library}\public_solution\msvs\` 

the binary file is located in `.\public_solution\binary\`

### Linux

```bash
git clone https://github.com/nescirem/Fortran_External_Library.git
cd Fortran_External_Library
chmod -R 711 ./
```

For the cases of Fortran link to Fortran external library, Intel Fortran and GNU Fortran is supported:

```bash
./fortran_dynamic_library/build.sh
./fortran_static_library/build.sh
```
For the cases of C++ link to Fortran external library, only GNU Fortran with g++ is supported:

```bash
./cpp_static_library/build.sh
./cpp_dynamic_library/build.sh
```

or you can specify compiler and debug mode like this:

```bash
./fortran_dynamic_library/build.sh ifort release
./fortran_static_library/build.sh gfortran debug
./cpp_static_library/build.sh debug
./cpp_dynamic_library/build.sh release
```

Remember to clean:

```bash
./fortran_dynamic_library/clean_all.sh
./fortran_static_library/clean_all.sh
./cpp_static_library/clean_all.sh
./cpp_dynamic_library/clean_all.sh
```



## Test

### Windows

Not recommended. If you want to use this PowerShell script, read help first:

```powershell
.\test_all.ps1 -h
```

>  Currently Intel Fortran projects (.vfproj) do not support MSBuild. So this PowerShell script uses devenv.exe to open the *.sln file which includes Intel Fortran projects and wait for the user to build it manually.

### Linux

Use python script to compile and test.

```python
python test_all.py
```



## To do

- [x] Linking third party Fortran dynamic library with C++ (linux)
- [ ] A more practical case



## License

All codes are released under [MIT](./LICENSE) license except `make_depends_tree.sh` in `./tools`



## Thanks to

[[pirpyn](https://github.com/pirpyn)]:  [Fortran-Project-Template](https://github.com/pirpyn/Fortran-Project-Template)

\[臭石头雪球]: http://v.fcode.cn/

\[Neo Insight!]: https://www.avex.idv.tw/?p=243

\[Calling Fortran from C/C++]: https://medium.com/@waltermateriais/calling-fortran-from-c-c-aa32867bde20

\[Calling C++ (cpp objects) from a Fortran subroutine]: (https://software.intel.com/en-us/forums/intel-visual-fortran-compiler-for-windows/topic/734563)

\[C++ Calls in Fortran]: https://modelingguru.nasa.gov/docs/DOC-2642

\[Using C/C++ and Fortran together]: http://www.yolinux.com/TUTORIALS/LinuxTutorialMixingFortranAndC.html

\[C++向Fortran链接库中传递字符串]: http://bbs.fcode.cn/thread-1117-1-1.html

