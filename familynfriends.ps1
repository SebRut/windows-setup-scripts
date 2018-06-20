###########
# functions
###########
function Test-IsAdmin {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    }
    catch {
        throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}
# Override the built-in cmdlet with a custom version
function Write-Error($message) {
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
}

$null = Start-Transcript "log.txt"

# check for admin rights
if (!(Test-IsAdmin)) {
    Write-Error "Insufficient rights detected, please run with administrator rights."
    exit
}

# check if chocolatey is installed
$ChocoInstalled = $false
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    $ChocoInstalled = $true
}

# install chocolatey
if (!$ChocoInstalled) {
    Write-Information "Installing chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Information "Powershell installed. Please reopen your shell and execute the script again."
}

# install base tools
# add package "ccleaner" when task configuration is added
$base_packages = @("unchecky", "7zip", "vlc", "adobereader", "adobereader-update")

# check for additional packages
$additional_packages = @()
[Console]::WriteLine("Pick additional packages. (Y/N)")
while( -not ( ($choice= (Read-Host "Google Chrome?")) -match "y|n")){ "Y or N ?"}
if($choice) {
    Write-Information "Google Chrome selected"
    $additional_packages += "googlechrome"
}
while( -not ( ($choice= (Read-Host "Mozilla Firefox?")) -match "y|n")){ "Y or N ?"}
if($choice) {
    Write-Information "Mozilla Firefox selected"
    $additional_packages += "firefox"
}
while( -not ( ($choice= (Read-Host "Paint.Net?")) -match "y|n")){ "Y or N ?"}
if($choice) {
    Write-Information "Paint.NET selected"
    $additional_packages += "paint.net"
}
while( -not ( ($choice= (Read-Host "Notepad++?")) -match "y|n")){ "Y or N ?"}
if($choice) {
    Write-Information "Notepad++ selected"
    $additional_packages += "notepadplusplus"
}

$packages = $base_packages + $additional_packages
Write-Information "Packages to be installed:"
$packages | ForEach-Object {Write-Information $_}

# install packages
choco install $packages -y

# ccleaner setup

# chocolatey update check

$null = Stop-Transcript