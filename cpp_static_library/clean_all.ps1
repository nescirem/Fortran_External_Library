# Clean up all Microsoft Visual Studio 
# solutions in the current directory.

###########################################################
# global variables
<#
$FileName	- [string] 	- Relative path to a directory or file
$fpath		- [string] 	- Relative path temp
$fileNames	- [list]	- Relative path to the directories and files
#>
###########################################################

# Entry point
set-location $PSScriptRoot

# common functions
. ..\tools\print_out_remove.ps1

# clean static_library
$FileName = ".\static_library\binary"

if (test-path $FileName) {
	write-host "Remove $FileName"
	remove-recursely($FileName)
}

$fpath=".\static_library\msvs\lib1"
$FileNames=get-childItem $fpath -Exclude *.vfproj
print-out-remove($fpath)

$fpath=".\static_library\msvs\lib_in_lib"
$FileNames=get-childItem $fpath -Exclude *.vfproj
print-out-remove($fpath)

$fpath=".\static_library\msvs"
$FileNames=get-childItem $fpath -Exclude *.sln,lib1,lib_in_lib
print-out-remove($fpath)


# clean public_solution
$FileName = ".\public_solution\binary"
if (test-path $FileName) {
	write-host "Remove $FileName"
	remove-recursely($FileName)
}

$fpath=".\public_solution\msvs\public_code"
$FileNames=get-childItem $fpath -Exclude *.vcxproj,*.filters,*.user
print-out-remove($fpath)

$fpath=".\public_solution\msvs"
$FileNames=get-childItem $fpath -Exclude *.sln,public_code
print-out-remove($fpath)
