# wall.ps1

# warning.png dosyasının TEMP klasöründeki yolu
$warningPath = Join-Path $env:TEMP "warning.png"

# Masaüstü yolu
$desktopPath = [Environment]::GetFolderPath("Desktop")
$wallpaperPath = Join-Path $desktopPath "warning.png"

# warning.png'yi masaüstüne kopyala (varsa üzerine yaz)
Copy-Item -Path $warningPath -Destination $wallpaperPath -Force

# Registry'de masaüstü arka planını ayarla
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d $wallpaperPath /f

# Windows'a arka planın değiştiğini bildir
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

# Alternatif olarak .NET üzerinden arka plan değişikliği (daha stabil olabilir)
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll",SetLastError=true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

[Wallpaper]::SystemParametersInfo(20, 0, $wallpaperPath, 3)

# Kendini sil (isteğe bağlı)
Remove-Item -Path $MyInvocation.MyCommand.Path -Force
