#!/bin/bash

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
none='\e[0m'

###################
# debug | release |
DEBUG=$1
###################


if [ `command -v gfortran` ];then 
	FCompiler="gfortran";
else
	echo -e "$red No supported fortran compiler is installed, please install GUN fortran$none" && exit 1
fi
if [ `command -v g++` ];then 
	CCompiler="g++"
else
	echo -e "$red No supported c++ compiler is installed, please install g++$none" && exit 1
fi

if [ -z $DEBUG  ]; then DEBUG="release"; fi;

shpath=$(cd `dirname $0`; pwd)

if [ `command -v sudo`  ];then
	sudo="sudo"
else
	sudo=""
fi

# make clean
echo -e "$yellow clean$none"
cd $shpath/public_solution && make clean
cd $shpath/static_library && make clean

# make static library
echo -e "$green build static library 'liblib.a'$none"
cd $shpath/static_library
make all FC=$FCompiler
cd $shpath/public_solution
if [[ -d ./library  ]]; then
	$sudo rm -rf ./library
fi
$sudo mkdir ./library
$sudo mv -f $shpath/static_library/liblib.a ./library/

# make executable program linking to the static library
echo -e "$green build executable file 'main'$none"
cd $shpath/public_solution
make all FC=$CCompiler DDBUG=$DEBUG

echo  -e "$green Done.$none"
echo

# run test
sleep 1
echo  -e "$green Run executable file './public_solution/binary/main'$none"
echo " --------------------------------"
cd $shpath/public_solution/binary
eval ./main
echo " --------------------------------"
