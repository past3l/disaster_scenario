

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$warningPath = Join-Path $scriptDir "warning.png"
$desktopPath = [Environment]::GetFolderPath("Desktop")
$wallpaperPath = Join-Path $desktopPath "warning.png"

Copy-Item -Path $warningPath -Destination $wallpaperPath -Force

reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d $wallpaperPath /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

Remove-Item -Path $MyInvocation.MyCommand.Path -Force
