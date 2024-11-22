# Define registry paths
$uninstallKeysPaths = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
)

# Get all uninstall keys
$uninstallKeys = Get-ChildItem -Path $uninstallKeysPaths

# Get application properties
$applicationKeys = $uninstallKeys | Get-ItemProperty | Where-Object { $_.DisplayName -and $_.UninstallString }

# Define the output file path
$outputFilePath = "C:\Temp\UninstallStrings.txt"

# Create Temp directory if it doesn't exist
if (!(Test-Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp"
}

# Clear the output file if it already exists
if (Test-Path $outputFilePath) {
    Clear-Content $outputFilePath
}

# Write application information to file
foreach ($applicationKey in $applicationKeys) {
    $applicationName = $applicationKey.DisplayName
    $uninstallString = $applicationKey.UninstallString
    Add-Content -Path $outputFilePath -Value "Application Name: $applicationName"
    Add-Content -Path $outputFilePath -Value "Uninstall String: $uninstallString"
    Add-Content -Path $outputFilePath -Value "-----------------------------"
}
