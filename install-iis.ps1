$install = Install-WindowsFeature -name Web-Server -IncludeManagementTools -ErrorAction Ignore

if($install.success -eq $true){
    write-output "IIS installation succeeded"
}else{
    write-output "Unable to install IIS"
    Write-Output $install.ExitCode
}