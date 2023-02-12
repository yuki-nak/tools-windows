$path = "$PSScriptRoot\target.txt"

if(Test-Path $path)
{
    $scopeList = Get-Content $path
}
else
{
    [System.Windows.Forms.MessageBox]::Show("[target.txt] is not here", "Connection Alert")
    return
}

foreach ($scope in $scopeList)
{
    try 
    {
        $ip = [System.Net.Dns]::GetHostAddresses($scope) | Select-Object IPAddressToString
        $status = @{
            "Server Name" = $scope
            "IP Address" = $ip.IPAddressToString
        }
    }
    catch 
    {
       $status = @{
            "Server Name" = $scope
            "IP Address" = "DNS Unresolved"
       }
    }

    New-Object -TypeName psobject -Property $status -OutVariable entity
    $groupedResult += $entity
}

$groupedResult | Out-GridView -Title "DNS Results"
pause
exit