# Fortran第三方链接库

![](https://img.shields.io/badge/platform-linux%20|%20windows-lightgrey.svg) ![](https://img.shields.io/badge/license-MIT-blue.svg)

Fortran静态/动态链接库的编译，
C++或Fortran链接到由Fortran编写的第三方链接库的简单演示，
以及其多平台项目管理。[[English](./README.md)]

<table>
 <tr align="center">
  <td>Platform</td>
  <td>Code</td>
  <td>Project</td>
  <td colspan=2>Compilers</td>
  <td>Build tools</td>
 </tr>
 <tr>
  <td rowspan=4 align="center">Linux</td>
  <td rowspan=2 align="center">C++</td>
  <td>Fortran External Library</td>
  <td align="center">GNU Fortran</td>
  <td align="center"></td>
  <td rowspan=4 align="center">GNU make</td>
 </tr>
 <tr>
  <td>C++ Project</td>
  <td align="center">GCC</td>
  <td align="center"></td>
 </tr>
 <tr>
  <td rowspan=2 align="center">Fortran</td>
  <td>Fortran External Library</td>
  <td align="center">GNU Fortran</td>
  <td align="center">Intel Fortran</td>
 </tr>
 <tr>
  <td>Fortran Project</td>
  <td align="center">GNU Fortran</td>
  <td align="center">Intel Fortran</td>
 </tr>
 <tr>
  <td rowspan=4 align="center">Windows</td>
  <td rowspan=2 align="center">C++</td>
  <td>Fortran External Library</td>
  <td align="center"></td>
  <td align="center">Intel Fortran</td>
  <td rowspan=4 align="center">Visual Studio</td>
 </tr>
 <tr>
  <td>C++ Project</td>
  <td align="center"></td>
  <td align="center">Intel C++</td>
 </tr>
 <tr>
  <td rowspan=2 align="center">Fortran</td>
  <td>Fortran External Library</td>
  <td align="center"></td>
  <td align="center">Intel Fortran</td>
 </tr>
 <tr>
  <td>Fortran Project</td>
  <td align="center"></td>
  <td align="center">Intel Fortran</td>
 </tr>
</table>


## 链接

- 源代码库: https://github.com/nescirem/Fortran_External_Library



## 需求

> 1. 将Fortran私有代码打包成静态或动态链接库，供外部C++/Fortran开发人员编译调用。
> 2. C++/Fortran代码项目使用他人编写的Fortran闭源链接库。
> 3. 多语言混合编程，或是在不影响程序正常使用的前提下逐步将Fortran代码改写为C++。

本演示案例"闭源部分"： `.\{language}_{Type_of_library}\{Type_of_library}\src\` ；"开源部分"：  `.\{language}_{Type_of_library}\public_solution\src\` 。

Fortran在链接到由Fortran编写的第三方链接库时较为麻烦的一点是：在编译时不但需要第三方链接库文件(*.lib或*.a)还需需要第三方链接库的Module接口代码。就是在链接到第三方链接库时必须先编译会被公开代码部分调用的删去了私有变量和过程的代码，得到 *.mod 文件。若没有这些 *.mod 文件，则会因为缺失module而无法编译链接到第三方链接库的可执行程序。因此这些 *.mod 文件起到的作用类似于C/C++的头文件。

"开源部分"中接口代码 `.\{language}_{Type_of_library}\public_solution\src\interface\` 是由"闭源部分"相应代码删去私有变量及过程得到的。



## 步骤

### Windows

使用Visual Studio 2010 sp1以上的版本打开 `lib.sln` 或 `dll.sln`（位于： `.\{laguage}_{Type_of_library}\{Type_of_library}\msvs\` ）：

**生成 - 批生成 - 全选 - 生成**

编译得到静态链接库文件lib_x64.lib 以及lib_x86.lib，或相应的动态链接库文件。

> 注意：本代码库所有案例的外部链接库的生成均为release模式，debug模式达不到闭源的要求

接下来同样地，打开位于 `.\{language}_{Type_of_library}\public_solution\msvs\` 的 `public_code.sln` 文件进行批生成。

> 这样的话，链接到由Fortran编写的第三方链接库的代码项目（公开代码部分）就算是debug模式也无法看到链接库内的代码，因为链接库内不包含Debug符号。

最后链接输出的可执行文件位于： `.\{language}_{Type_of_library}\public_solution\binary\`

由于目前MSBuild不支持Intel Fortran，所以我们无法通过powershell批量编译所有解决方案。但可以使用powersell脚本调用辅助编译并测试所有的 `*.exe` 可执行文件。在执行脚本前请务必关闭所有的devenv.exe窗口并仔细阅读帮助说明：

```powershell
.\test_all.ps1 -h
```

### Linux

```bash
git clone https://github.com/nescirem/Fortran_External_Library.git
cd Fortran_External_Library
chmod -R 711 ./
```

自动选择编译器并构建（Fortran链接到Fortran第三方链接库的案例支持 Intel Fortran 与 GNU Fortran，而C++链接到Fortran第三方链接库的案例只支持 g++ 链接到 GNU Fortran 生成的库）：

```bash
./fortran_dynamic_library/build.sh
./fortran_static_library/build.sh
./cpp_static_library/build.sh
./cpp_dynamic_library/build.sh
```

或指定编译器与释出模式构建：

```bash
./fortran_dynamic_library/build.sh ifort release
./fortran_static_library/build.sh gfortran debug
./cpp_static_library/build.sh debug
./cpp_dynamic_library/build.sh release
```

清理：

```bash
./fortran_dynamic_library/clean_all.sh
./fortran_static_library/clean_all.sh
./cpp_static_library/clean_all.sh
./cpp_dynamic_library/clean_all.sh
```

你也可以选择使用python脚本构建并测试所有二进制文件：

```python
python test_all.py
```



## To do

- [x] Linux平台下C ++链接到第三方Fortran动态链接库
- [ ] 更加具体的案例



## 开源协议

除 `./tools`中的`make_depends_tree.sh` 外，其他代码均以 [MIT](./LICENSE) 协议开源。



## 感谢

[[pirpyn](https://github.com/pirpyn)]: [Fortran-Project-Template](https://github.com/pirpyn/Fortran-Project-Template)

\[臭石头雪球]: http://v.fcode.cn/

\[Neo Insight!]: https://www.avex.idv.tw/?p=243

\[Calling Fortran from C/C++]: https://medium.com/@waltermateriais/calling-fortran-from-c-c-aa32867bde20

\[Calling C++ (cpp objects) from a Fortran subroutine]: (https://software.intel.com/en-us/forums/intel-visual-fortran-compiler-for-windows/topic/734563)

\[C++ Calls in Fortran]: https://modelingguru.nasa.gov/docs/DOC-2642

\[Using C/C++ and Fortran together]: http://www.yolinux.com/TUTORIALS/LinuxTutorialMixingFortranAndC.html

\[C++向Fortran链接库中传递字符串]: http://bbs.fcode.cn/thread-1117-1-1.html

