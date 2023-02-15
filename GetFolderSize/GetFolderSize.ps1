$ErrorActionPreference = "silentlycontinue"

Write-Host  "Get folder size and the number of files. It may take some hours if the target is large. Do not close this window before finishing." 
$targetDir = (Read-Host "Please inpuy the folder path:")

$scopeList = Get-ChildItem

funciton GetFolderSize 
{
    
}
