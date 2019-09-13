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
	sudo rm -rf ./library  >/dev/null 2>&1
fi

modules=$(find . -maxdepth 1 -name "*.mod"  | tr '\n'  ' ')
rmmodules=$(echo $modules | sed 's/.\//public_solution\//g')
echo "remove: $rmmodules"
sudo rm $modules >/dev/null 2>&1

modules=$(find . -maxdepth 1 -name "*.f90"  | tr '\n'  ' ')
rmmodules=$(echo $modules | sed 's/.\//public_solution\//g')
echo "remove: $rmmodules"
sudo rm $modules >/dev/null 2>&1
echo 

echo 'remove: static_library/liblib.a static_library/objects'
cd $shpath/static_library && make clean >/dev/null 2>&1

echo 'remove: static_library/binary'
if [[ -d ./binary  ]]; then
	sudo rm -rf ./binary
fi

modules=$(find . -maxdepth 1 -name "*.mod"  | tr '\n'  ' ')
rmmodules=$(echo $modules | sed 's/.\//static_library\//g')
echo "remove: $rmmodules"
sudo rm $modules >/dev/null 2>&1
echo 

echo  -e "$green Done.$none"
echo 
