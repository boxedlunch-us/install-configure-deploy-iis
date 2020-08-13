Import-Module webadministration

$webAppName = "WebApp"
$webroot = "C:\webroot"
# Remove default web application
$default = Get-IISSite -Name "Default Web Site" -WarningAction SilentlyContinue

if($default -ne $null){

    Remove-IISSite $default -Confirm:$false

}


# Create new web application
if((Get-IISSite -Name $webAppName) -eq $null){

    New-IISSite -Name $webAppName -PhysicalPath $webroot -BindingInformation http *:80:
    New-WebBinding -Name $webAppName -Protocol http -Port 80 -IPAddress *

}

# Prep IIS for hosting .net core applications
Invoke-WebRequest -Uri https://download.visualstudio.microsoft.com/download/pr/21a5322f-cf9c-40e0-af41-4cdf14b3fb17/ff1390906525099bcd6b322279e09938/dotnet-hosting-3.1.7-win.exe -OutFile dotnet-hosting-3.1.7-win.exe

Start-Process -FilePath ".\dotnet-hosting-3.1.7-win.exe" -ArgumentList "/quiet" -wait