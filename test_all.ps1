# CLOSE ANY VISUAL STUDIO WINDOWS BEFORE RUNING THIS SCRIPT.

# test all projects                  USAGE: `.\test_all.ps1`
# clean all projects                 USAGE: `.\test_all.ps1 -c`
# build and test all projects        USAGE: `.\test_all.ps1 -b`
# rebuild and test all projects      USAGE: `.\test_all.ps1 -c -b`
# build all projects but don't test  USAGE: `.\test_all.ps1 -b -t:$false`

param (
	[switch]$h=$false,
    [switch]$c=$false,
	[switch]$b=$false,
	[switch]$t=$true
)

# Print multi-color strings one line.
function write-color([String[]]$Text, [ConsoleColor[]]$Color="White", [int]$StartTab=0, [int] $LinesBefore=0,[int] $LinesAfter=0, [string] $LogFile="", $TimeFormat="yyyy-MM-dd HH:mm:ss") {
	$DefaultColor=$Color[0]
	if ($LinesBefore -ne 0) { for ($i=0; $i -lt $LinesBefore; $i++) { write-host "`n" -NoNewline } } # Add empty line before
	if ($StartTab -ne 0) { for ($i=0; $i -lt $StartTab; $i++) { write-host "`t" -NoNewLine } } # Add TABS before text
	if ($Color.Count -ge $Text.Count) {
		for ($i=0; $i -lt $Text.Length; $i++) { write-host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
	} 
	else {
		for ($i=0; $i -lt $Color.Length ; $i++) { write-host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
		for ($i=$Color.Length; $i -lt $Text.Length; $i++) { write-host $Text[$i] -ForegroundColor $DefaultColor -NoNewLine }
	}
	write-host
	if ($LinesAfter -ne 0) { for ($i=0; $i -lt $LinesAfter; $i++) { write-host "`n" } } # Add empty line after
	if ($LogFile -ne "") {
		$TextToFile=""
		for ($i=0; $i -lt $Text.Length; $i++) {
			$TextToFile += $Text[$i]
		}
		write-output "[$([datetime]::Now.ToString($TimeFormat))]$TextToFile" | Out-File $LogFile -Encoding unicode -Append
	}
}
# Remove all line breaks in the string
function RemoveLineCarriage($object) {
	$result=[System.String] $object
	$result=$result -replace "`t",""
	$result=$result -replace "`n",""
	$result=$result -replace "`r",""
	$result=$result -replace " ;",";"
	$result=$result -replace "; ",";"
	$result=$result -replace [Environment]::NewLine, ""
	$result;
}


# Remove all space and line breaks in the string
function clean-str($string) {
	$result=RemoveLineCarriage($string)
	$result=$result -replace '\s',''
	$result;
}

function check-file($PathRcv) {
	foreach ($fileName in $fileNames) {
		$pathbrt=$PathRcv+$fileName
		if (test-path -Path $pathbrt) {
			$result=$true
		} else {
			$result=$false
			break
		}
	}
	$result;
}

function build-sln($PathRecv) {
	if (test-path variable:builded){del variable:builded}
	$builded=check-file($PathRecv)
	
	# Check if all the build process is completed. if completed then close all Visual Studio windows
	function waite-file($PathRecv) {
		while ($builded -eq $false) {
			write-host -NoNewline "."
			start-sleep -Seconds 1
			$builded=check-file($PathRecv)
		}
		start-sleep -Seconds 3
		$closed=get-process devenv | % { $_.CloseMainWindow() }
		start-sleep -Seconds 1
		write-host "Done."
		write-output ""
	}
	
	if ($builded -eq $false) { 
		$str=$libtype -replace "_"," "
		write-output "Missing $str, rebuild!"
		Invoke-Item $pathf
		write-host "Please Build all projects manualy!" -ForegroundColor White -BackgroundColor Blue
		write-output "   ------------------------------------------ "
		write-output "  | Build - Batch Build - Select all - Build |"
		write-output "   ------------------------------------------ "
		waite-file($PathRecv)
	}
	
}

function clean-all() {
	function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
	write-host "Clean" -ForegroundColor Yellow
	write-output ""
	#------------------------------------------------------
	$ScriptPath="fortran_static_library\clean_all.ps1"
	write-output "FORTRAN_STATIC_LIBRARY"
	$script=join-path (Get-ScriptDirectory) $ScriptPath
	. $script
	set-location $PSScriptRoot
	#------------------------------------------------------
	$ScriptPath="fortran_dynamic_library\clean_all.ps1"
	write-output ""
	write-output "FORTRAN_DYNAMIC_LIBRARY"
	$script=join-path (Get-ScriptDirectory) $ScriptPath
	. $script
	set-location $PSScriptRoot
	#------------------------------------------------------
	# add script here
	#------------------------------------------------------
	write-output ""
	write-host "Done." -ForegroundColor Green
	write-output ""
}

function select-mode($cmmod) {
	$libmode=$libtype.ToUpper()
	switch ($cmmod) {
		"main.exe" {$result=$libmode+" release x64: "}
		"maind.exe" {$result=$libmode+" debug x64: "}
		"main_x86.exe" {$result=$libmode+" release x86: "}
		"maind_x86.exe" {$result=$libmode+" debug x86: "}
	}
	$result;
}

function print-test($mode) {
	if ($resulted -eq $expected) { write-color -Text $mode,"[PASS]" -Color White,Green } 
	else { write-color -Text $mode,"[ERROR]" -Color White,Red }
}

function test-exec($PathRecv) {
	write-output ""
	foreach ($exex in $exef) {
		$resulted=""
		$cline=$PathRecv+$exex
		if (test-path -Path $cline) {
			$str=& $cline
			$resulted=clean-str($str)
		}
		$mode=select-mode($exex)
		print-test($mode)
	}
}

###########################################################
# global variables
<#
$str		- [string] 	- Temp string
$expected	- [string] 	- The expected output of the executable file
$exef		- [list]	- Executable file names
$libtype	- [string]	- Library type
$pathp		- [string]	- Relative path to public_solution directory
$pathl		- [string]	- Relative path to the {LIBRARY} directory
$solutionf	- [string]	- The name of the Microsoft Visual Studio solution file
$pathf		- [string]	- Relative path to the Microsoft Visual Studio solution file
$fileNames	- [list]	- Expected build out files of the solution
$PathSend	- [string]	- The relative path to the directory where the solution builds the binary file
#>
###########################################################

# Entry point
set-location $PSScriptRoot

write-output ""
if ($h) {
    write-host "[WARNING]:" -ForegroundColor Red
    write-host "    CLOSE ANY VISUAL STUDIO WINDOWS BEFORE RUNING THIS SCRIPT!"
	write-host ""
	write-host "[USAGE]:"
	write-host "    -b  build all projects."
	write-host "    -c  clean all projects."
	write-host "    -h  print this help and exit."
	write-host "    -t  test all projects."
	write-host "    -t:$false  don't do any test."
	write-host ""
	break
}

if ($c) {
	clean-all
	# if has cleaned up but not build again, do not test.
	if ( -not ($b) ) { break }
}

#------------------------------------------------------
$str=get-content ".\expect\lib_expect.txt"
$expected=clean-str($str)


$exef="main.exe", "maind.exe", "main_x86.exe", "maind_x86.exe"
$libtype="static_library"
$pathp=".\fortran_"+$libtype+"\public_solution\"
$pathl=".\fortran_"+$libtype+"\"+$libtype+"\"

if ($b) { 
	$solutionf="lib.sln"
	$pathf=$pathl+"msvs\"+$solutionf
	$fileNames="lib_x64.lib","lib_x86.lib"
	$PathSend=$pathl+"binary\"

	build-sln($PathSend)

	$solutionf="public_code.sln"
	$pathf=$pathp+"msvs\"+$solutionf
	$fileNames=$exef
	$PathSend=$pathp+"binary\"

	build-sln($PathSend)
}

if ($t) {
	$PathSend=$pathp+"binary\"
	test-exec($PathSend)
}
write-output ""
#------------------------------------------------------
$str=get-content ".\expect\dll_expect.txt"
$expected=clean-str($str)

$exef="main.exe", "maind.exe", "main_x86.exe", "maind_x86.exe"
$libtype="dynamic_library"
$pathp=".\fortran_"+$libtype+"\public_solution\"
$pathl=".\fortran_"+$libtype+"\"+$libtype+"\"

if ($b) { 
	$solutionf="dll.sln"
	$pathf=$pathl+"msvs\"+$solutionf
	$fileNames="dll_x64.dll","dll_x86.dll","dll_x64.lib","dll_x86.lib"
	$PathSend=$pathl+"binary\"
	
	build-sln($PathSend)

	$solutionf="public_code.sln"
	$pathf=$pathp+"msvs\"+$solutionf
	$fileNames=$exef+"dll_x64.dll"+"dll_x86.dll"
	$PathSend=$pathp+"binary\"
	
	build-sln($PathSend)
}

if ($t) {
	$PathSend=$pathp+"binary\"
	test-exec($PathSend)
}
write-output ""
#------------------------------------------------------
# add another build and test here
#------------------------------------------------------
