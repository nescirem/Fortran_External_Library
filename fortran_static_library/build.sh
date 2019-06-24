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
cd $shpath/static_library && make clean

echo -e "$green build static library 'liblib.a'$none"
cd $shpath/static_library
make all
cd $shpath/public_solution
if [[ -d ./library  ]]; then
	sudo rm -rf ./library
fi
sudo mkdir ./library
sudo mv -f $shpath/static_library/liblib.a ./library/

echo -e "$green build executable file 'main'$none"
cd $shpath/public_solution
make all

echo  -e "$green Done.$none"
echo

sleep 1
echo  -e "$green Run executable file './public_solution/binary/main'$none"
echo -e "$red --------------------------------$none"
cd $shpath/public_solution/binary
eval ./main
echo -e "$red --------------------------------$none"
