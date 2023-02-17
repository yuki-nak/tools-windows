$ErrorActionPreference = "silentlycontinue"

Write-Host  "Get folder size and the number of files. It may take some hours if the target is large. Do not close this window before finishing." 
$targetDir = (Read-Host "Please input the folder path")

$scopeList = Get-ChildItem $targetDir -Name -Directory

function GetFolderSize
{
    foreach ($scope in $scopeList)
    {
        $dirInfo = Get-ChildItem "$targetDir¥$scope" -Recurse | Measure-Object -Property Length -Sum
        $lastWriteAccess = Get-ItemProperty "$targetDir¥$scope"
        $item = @{
            "Path" = $targetDir
            "Date Scanned" = (Get-Date -Format g)
            "Folder Name" = $scope
            "Total GB" = $dirInfo.Sum/(1024*1024*1024)
            "Total Item" = $dirInfo.Count
            "Last Access Time" = $lastWriteAccess.LastAccessTime
        }

        New-Object -TypeName PSObject -Property $item -OutVariable destItem
        $groupedResult += $destItem
    }

    $logHistory = $groupedResult | Export-Csv "$PSScriptRoot¥Result_History.csv" -Append -NoTypeInformation -Encoding Default
    $logLatest = $groupedResult | Export-Csv "$PSScriptRoot¥Result_Latest.csv" -NoTypeInformation -Encoding Default
}

Write-Host "Scanning now ..."
GetFolderSize | Out-GridView -Title "Data Size Scan"
Write-Host "Finished!"

pause
