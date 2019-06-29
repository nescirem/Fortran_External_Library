function print-out-remove($recvpath)
{
	function relative-path($recvpath)
	{
		$found = $file -match '(\\[^\\]*)$'
		if ($found) {
			$file=$recvpath+$matches[1]
			write-host "Remove $file"
			remove-recursely($file)
		}
		
	}
	foreach ($file in $fileNames) {
		relative-path($recvpath)
	}
}

function remove-recursely($filerecv)
{
	remove-item -Recurse $filerecv
}
