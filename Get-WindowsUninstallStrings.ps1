$uninstallKeysPaths = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
$uninstallKeys = Get-ChildItem -Path $uninstallKeysPaths
$applicationKeys = $uninstallKeys | Get-ItemProperty | Where-Object { $_.DisplayName -and $_.UninstallString }

# Define the output file path
$outputFilePath = "C:\Temp\UninstallStrings.txt"

# Clear the output file if it already exists
if (Test-Path $outputFilePath) {
    Clear-Content $outputFilePath
}

foreach ($applicationKey in $applicationKeys) {
    $applicationName = $applicationKey.DisplayName
    $uninstallString = $applicationKey.UninstallString
    Add-Content -Path $outputFilePath -Value "Application Name: $applicationName"
    Add-Content -Path $outputFilePath -Value "Uninstall String: $uninstallString"
    Add-Content -Path $outputFilePath -Value "-----------------------------"
}