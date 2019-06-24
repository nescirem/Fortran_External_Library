#!/bin/bash

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'

shpath=$(cd `dirname $0`; pwd)

if [ `command -v sudo`  ];then
	sudo="sudo"
else
	sudo=""
fi

# unalias cp

echo -e "$yellow clean$none"
cd $shpath/public_solution && make clean
cd $shpath/dynamic_library && make clean

echo -e "$green build dynamic library 'libdll.so'$none"
cd $shpath/dynamic_library
make all
#sudo cp -rf libdll.so /usr/lib/
sudo mv -f libdll.so ../public_solution/

echo -e "$green build executable file 'main'$none"
cd $shpath/public_solution
make all

if [[ -d ./library  ]]; then
	sudo rm -rf ./library
fi
sudo mkdir ./library
sudo mv -f libdll.so ./library/

echo  -e "$green Done.$none"
echo

sleep 1
echo  -e "$green Run executable file './public_solution/binary/main'$none"
echo -e "$red --------------------------------$none"
cd $shpath/public_solution
export LD_LIBRARY_PATH=./library
eval ./binary/main
echo -e "$red --------------------------------$none"
