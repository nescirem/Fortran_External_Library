# fortran第三方链接库

fortran第三方静态/链接库的编译及调用。[[English](./README.md)]



## 需求

> 1. 将闭源项目打包成静态或动态链接库，将其中的部分代码文件开源（必须提供相应的"接口代码"）。
> 2. 使用他人编写的闭源链接库（需要对方提供相应的"interface"）。
> 3. 多语言混合编程（扯淡）。

本演示案例"闭源部分"： `.\fortran_{Type_of_library}\{Type_of_library}\src\` ；"开源部分"：  `.\fortran_{Type_of_library}\public_solution\src\` 。

"开源部分"中接口代码 `.\fortran_{Type_of_library}\public_solution\src\interface\` 是由"闭源部分"相应代码删去私有变量及过程得到的。



## 步骤

### Windows

使用Visual Studio 2015以上的版本打开 `lib.sln` 或 `dll.sln`（位于： `.\fortran_{Type_of_library}\{Type_of_library}\msvs\` ）：

**生成 - 批生成 - 全选 - 生成**

编译得到了静态链接库文件lib_x64.lib 以及lib_x86.lib，或相应的动态链接库文件。

> 注意：此处外部链接库的生成均为release模式，debug模式达不到闭源的要求

接下来同样地，打开位于 `.\fortran_{Type_of_library}\public_solution\msvs\` 的 `public_code.sln` 文件进行批生成。

最后链接输出的可执行文件位于： `.\fortran_{Type_of_library}\public_solution\binary\`

### Linux

构建：

```bash
./fortran_dynamic_library/build.sh
./fortran_static_library/build.sh
```

清理：

```bash
./fortran_dynamic_library/clean_all.sh
./fortran_static_library/clean_all.sh
```



## 感谢

[[pirpyn](https://github.com/pirpyn)]:  [Fortran-Project-Template](https://github.com/pirpyn/Fortran-Project-Template)

