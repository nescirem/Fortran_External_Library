#!/bin/bash

green='\e[92m'
yellow='\e[93m'
none='\e[0m'

shpath=$(cd `dirname $0`; pwd)
if [ `command -v sudo`  ];then
	sudo="sudo"
else
	sudo=""
fi


echo -e "$yellow Clean$none"
echo 'remove: public_solution/binary public_solution/objects'
cd $shpath/public_solution && make clean >/dev/null 2>&1

echo 'remove: public_solution/library'
if [[ -d ./library  ]]; then
	sudo rm -rf ./library
fi
echo 

echo 'remove: dynamic_library/libdll.so dynamic_library/objects'
cd $shpath/dynamic_library && make clean >/dev/null 2>&1

echo 'remove: dynamic_library/binary'
if [[ -d ./binary  ]]; then
	sudo rm -rf ./binary
fi


echo  -e "$green Done.$none"
echo 
