# param([string]$DesiredIP = "127.0.0.1"
#     ,[string]$Hostname = "tomssl.local"
# 	,[bool]$CheckHostnameOnly = $false)
# Adds entry to the hosts file.

$hostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"
$hostsFile = Get-Content $hostsFilePath

$Hostnames = @("xxxx","xxxx","xxxxx","xxxxx")
$DesiredIP = "192.168.255.255"
$CheckHostnameOnly = $false

foreach ($Hostname in $Hostnames) {
    Write-Host "About to add $desiredIP for $Hostname to hosts file" -ForegroundColor Gray

    $escapedHostname = [Regex]::Escape($Hostname)
    $patternToMatch = If ($CheckHostnameOnly) { ".*\s+$escapedHostname.*" } Else { ".*$DesiredIP\s+$escapedHostname.*" }
    If (($hostsFile) -match $patternToMatch)  {
        Write-Host $desiredIP.PadRight(20," ") "$Hostname - not adding; already in hosts file" -ForegroundColor DarkYellow
    } 
    Else {
        Write-Host $desiredIP.PadRight(20," ") "$Hostname - adding to hosts file... " -ForegroundColor Yellow -NoNewline
        Add-Content -Encoding UTF8  $hostsFilePath ("$DesiredIP".PadRight(20, " ") + "$Hostname")
        Write-Host " done"
    }
}