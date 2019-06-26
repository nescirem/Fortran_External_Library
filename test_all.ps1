function write-color([String[]]$Text, [ConsoleColor[]]$Color = "White", [int]$StartTab = 0, [int] $LinesBefore = 0,[int] $LinesAfter = 0, [string] $LogFile = "", $TimeFormat = "yyyy-MM-dd HH:mm:ss") 
{
	$DefaultColor = $Color[0]
	if ($LinesBefore -ne 0) { for ($i = 0; $i -lt $LinesBefore; $i++) { Write-Host "`n" -NoNewline } } # Add empty line before
	if ($StartTab -ne 0) { for ($i = 0; $i -lt $StartTab; $i++) { Write-Host "`t" -NoNewLine } } # Add TABS before text
	if ($Color.Count -ge $Text.Count) {
		for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
	} 
	else {
		for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
		for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $DefaultColor -NoNewLine }
	}
	write-host
	if ($LinesAfter -ne 0) { for ($i = 0; $i -lt $LinesAfter; $i++) { Write-Host "`n" } } # Add empty line after
	if ($LogFile -ne "") {
		$TextToFile = ""
		for ($i = 0; $i -lt $Text.Length; $i++) {
			$TextToFile += $Text[$i]
		}
		write-output "[$([datetime]::Now.ToString($TimeFormat))]$TextToFile" | Out-File $LogFile -Encoding unicode -Append
	}
}

function print-test($mode)
{
	if($result -eq $expected) {
		write-color -Text $mode,"[PASS]" -Color White,Green
	} else {
		write-color -Text $mode,"[ERROR]" -Color White,Red
	}
}

function RemoveLineCarriage($object)
{
	$result = [System.String] $object;
	$result = $result -replace "`t","";
	$result = $result -replace "`n","";
	$result = $result -replace "`r","";
	$result = $result -replace " ;",";";
	$result = $result -replace "; ",";";
	
	$result = $result -replace [Environment]::NewLine, "";
	
	$result;
}

function clean-str($string)
{
	$result = RemoveLineCarriage($string);
	$result = $result -replace '\s','';
	
	$result;
}

function select-mode($c)
{
	$libmode=$libtype.ToUpper();
	switch($c){
		"main.exe" {$result=$libmode+" release x64: "}
		"maind.exe" {$result=$libmode+" debug x64: "}
		"main_x86.exe" {$result=$libmode+" release x86: "}
		"maind_x86.exe" {$result=$libmode+" debug x86: "}
	};
	$result;
}



write-output ""
$str=Get-Content ".\expect\lib_expect.txt"
$expected=clean-str($str)

$exef="main.exe", "maind.exe", "main_x86.exe", "maind_x86.exe"
$libtype="static_library"
$pathf=".\fortran_"+$libtype+"\public_solution\binary\"
foreach ($c in $exef)
{
	$cline=$pathf+$c
    $str=&$cline
	$result=clean-str($str)
	$mode=select-mode($c)
	print-test($mode)
}

write-output ""

$str=Get-Content ".\expect\dll_expect.txt"
$expected=clean-str($str)

$libtype="dynamic_library"
$pathf=".\fortran_"+$libtype+"\public_solution\binary\"
foreach ($c in $exef)
{
	$cline=$pathf+$c
    $str=&$cline
	$result=clean-str($str)
	$mode=select-mode($c)
	print-test($mode)
}

write-output ""
