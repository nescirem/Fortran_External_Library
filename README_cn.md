# fortran静态链接库

fortran静态链接库在 Visual Studio + Intel Visual Fortran 上的编译以及使用方式演示。[[English](./README.md)]

***

## 需求

> 将闭源项目打包成静态链接库，将其中的部分代码文件开源。

本演示案例"闭源部分"： `.\static_library\src\` ；"开源部分"：  `.\public_solution\src\` 。

"开源部分"中接口代码 `.\public_solution\src\interface\` 是由"闭源部分"相应代码删去私有变量及过程得到的。

***

## 步骤

使用Visual Studio 2015以上的版本打开 `lib.sln` 或 `dll.sln`（位于： `.\fortran_{Type_of_library}\{Type_of_library}\msvs\` ）：

**生成 - 批生成 - 全选 - 生成**

编译得到了静态链接库文件lib_x64.lib 以及lib_x86.lib，或相应的动态链接库文件。

同样地，打开位于 `.\fortran_{Type_of_library}\public_solution\msvs\` 的 `public_code.sln` 文件进行批生成。

最后链接输出的可执行文件位于： `.\public_solution\binary\`

