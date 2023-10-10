 function GetDiskUsage
{
  #Check C drive only
   $scope = Get-PSDrive C
        $item = @{
            "Date Scanned" = (Get-Date -Format g)
            "Hostname" = $env:COMPUTERNAME
            "Scanned By" = $env:USERNAME
            "Name" = $scope.Name
            "Used (GB)" = $scope.Used/(1024*1024*1024)
            "Free (GB)" = $scope.Free/(1024*1024*1024)


        }

        New-Object -TypeName PSObject -Property $item -OutVariable destItem


    $destItem | Export-Csv "$PSScriptRoot¥_Latest.csv" -NoTypeInformation -Encoding Default
}

Write-Host "Scanning now ..."
GetDiskUsage | Out-GridView -Title "Data Size Scan"
Write-Host "Finished!"
pause 
