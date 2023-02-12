$logDir = $PSScriptRoot
Write-Host "Checking my Windows Update ..."

$Hotfix = Get-HotFix | Select-Object PSComputerName, InstalledOn, HotfixID, Description, Installedby | Sort-Object InstalledOn
$Hotfix | Export-Csv -NoTypeInformation "$logDir\$env:COMPUTERNAME.csv"

if ($false -eq $?)
{
    Write-Host "Faild!!"
    pause
}
else 
{
    Write-Host "Succeeded!!"
    Write-Host "Output is here:$logDir"
}

exit