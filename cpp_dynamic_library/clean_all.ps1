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

# clean dynamic_library
$FileName = ".\dynamic_library\binary"

if (test-path $FileName) {
	write-host "Remove $FileName"
	remove-recursely($FileName)
}

$fpath=".\dynamic_library\msvs\dll1"
$FileNames=get-childItem $fpath -Exclude *.vfproj
print-out-remove($fpath)

$fpath=".\dynamic_library\msvs"
$FileNames=get-childItem $fpath -Exclude *.sln,dll1
print-out-remove($fpath)


# clean static_library
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
