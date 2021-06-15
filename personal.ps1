# configure stuff
Disable-GameBarTips
Disable-BingSearch

# configure explorer
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

# install critical updates
Install-WindowsUpdate -AcceptEula

# install packages
cinst unchecky
cinst 7zip.install
cinst vlc
cinst googlechrome
cinst vscode
cinst notepadplusplus.install
cinst git.install
cinst python3
cinst openssh
cinst powertoys
cinst thunderbird
cinst gpg4win
cinst paint.net
cinst sharex
cinst microsoft-windows-terminal
cinst filezilla
cinst spotify