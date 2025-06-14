$driveD = Get-PSDrive -Name D -ErrorAction SilentlyContinue
if ($driveD -and $driveD.Provider.Name -eq 'FileSystem') {
    Write-Host "Dドライブが存在します（ファイルシステム）"
} else {
    Write-Host "Dドライブが存在しません"
}