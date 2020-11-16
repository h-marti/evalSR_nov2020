# Auto install wireguard on Windows
# https://download.wireguard.com/windows-client/wireguard-installer.exe

$url = "https://download.wireguard.com/windows-client/wireguard-installer.exe"
$output = "D:\Téléchargements\wireguard-installer.exe" 
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

D:\Téléchargements\wireguard-installer.exe
