$webroot = "C:\webroot"
if((test-path -path $webroot) -ne $true){
    $dir = New-Item -Path $webroot -ItemType Directory -Confirm:$false
}



$acl = Get-Acl $dir.FullName

$permissions = @("BUILTIN\IIS_IUSRS")

foreach($user in $permissions){
    
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "ReadAndExecute,ListDirectory", "ContainerInherit,ObjectInherit", "None", "Allow")
    $acl.SetAccessRule($AccessRule)
}


$acl | Set-Acl $dir.FullName