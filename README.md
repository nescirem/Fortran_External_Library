# Fortran External Dynamic & Static Linking  Library

![](https://img.shields.io/badge/platform-linux%20|%20windows-lightgrey.svg) ![](https://img.shields.io/badge/license-MIT-blue.svg)

Compile and the usage of third-party Fortran static library & dynamic library. [[中文](./README_cn.md)]



## Links

* Source code repository: https://github.com/nescirem/Fortran_External_Library



## Build

### Windows

open `lib.sln` or `dll.sln` with visual studio (>2010 sp1)  which is located in `.\fortran_{Type_of_library}\{Type_of_library}\msvs\` :

**Build - Batch Build - Select all - Build**

then similar operations with `public_code.sln` which is located in `.\fortran_{Type_of_library}\public_solution\msvs\` 

the binary file is located in `.\public_solution\binary\`

### Linux

```bash
git clone https://github.com/nescirem/Fortran_External_Library.git
cd Fortran_External_Library
chmod -R 711 ./
```

Intel Fortran and GNU Fortran is supported.

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

- [ ] A more practical case
- [ ] Linking third party Fortran static  library with C++



## License

All codes are released under [MIT](./LICENSE) license except `make_depends_tree.sh` in `./tools`



## Thanks to

[[pirpyn](https://github.com/pirpyn)]:  [Fortran-Project-Template](https://github.com/pirpyn/Fortran-Project-Template)

\[臭石头雪球]: http://v.fcode.cn/

\[Neo Insight!]: https://www.avex.idv.tw/?p=243

