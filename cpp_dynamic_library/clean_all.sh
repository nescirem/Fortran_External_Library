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

echo 'remove: public_solution/libdll.so'
if [[ -f ./libdll.so  ]]; then
	sudo rm -rf ./libdll.so >/dev/null 2>&1
fi

echo 'remove: dynamic_library/libdll.so dynamic_library/objects'
cd $shpath/dynamic_library && make clean >/dev/null 2>&1

echo 'remove: dynamic_library/binary'
if [[ -d ./binary  ]]; then
	sudo rm -rf ./binary >/dev/null 2>&1
fi

modules=$(find . -maxdepth 1 -name "*.mod"  | tr '\n'  ' ')
rmmodules=$(echo $modules | sed 's/.\//dynamic_library\//g')
echo "remove: $rmmodules"
sudo rm $modules >/dev/null 2>&1
echo 

echo  -e "$green Done.$none"
echo 
