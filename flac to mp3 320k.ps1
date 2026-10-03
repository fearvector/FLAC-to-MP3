$originalMusic = Get-ChildItem *.FLAC -Recurse

foreach ($inputMusic in $originalMusic) {
    $outputMusic = [io.path]::ChangeExtension($inputMusic.FullName, '.mp3')
    $fileName = Split-Path $inputMusic -leaf
	
	ffmpeg.exe -i $inputMusic.FullName -ab 320k -map_metadata 0  -id3v2_version 3 -write_id3v1 1 $outputMusic
	if ((Test-Path -path $inputMusic) -and (Test-Path -path $outputMusic)){
		Write-Host "Deleting input FLAC file: $fileName"
		Remove-Item $inputMusic
		Start-Sleep -s 1
	}
}

if ($PSScriptRoot -ne "C:\Users\ricky\Desktop\Coding Projects\Lidarr") {
		Write-Host "Removing remotely deployed ffmpeg script..."
		Start-Sleep -s 1
		
		$batPath = $PSScriptRoot + "\flac to mp3 320k.ps1"
		$ps1Path = $PSScriptRoot + "\flac to mp3 320k.bat"
		Remove-Item $batPath
		Remove-Item $ps1Path
	}