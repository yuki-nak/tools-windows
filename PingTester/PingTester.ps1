
Add-Type -AssemblyName System.Windows.Forms

# ---------------- !!!ATTENTION!!! -----------------
# Do not set large size of "$times" or "$packet_size". 
# It might be suspected as ping flooding.
# --------------------------------------------------

# Properties for Test-Coneection
$scopelist = Get-Content $PSScriptRoot\ping.txt
$global:group = $()
$times = 4
$packet_size = 1452



# execute Ping command
foreach ($scope in $scopelist)
{
    $execute_ping = Test-Connection $scope -BufferSize $packet_size -Count $times -ea 0
    $edit_responsetime = $execute_ping.responsetime | Measure-Object -Average | Select-Object Average

    $status = @{
        "Destination" = $scope; 
        "Date" = (get-date -format g);
        "Responsetime"= $edit_responsetime.Average
    }
    
    New-Object -TypeName PSObject -Property $status -OutVariable Dest_status
    $group += $Dest_status
}

#Export a log file
$group | export-csv $PSScriptRoot\logs.csv -Append -NoTypeInformation -Encoding Default

#Deactivate all the following lines if you set this script as Scheduled task.
$group | Out-GridView -Title "Ping Results"


#Alert POP-UP
$Alert = $group | Where-Object{$null -eq $_.Responsetime} | Select-Object Destination
$Alert_destname = $Alert.Destination

$Alert_destname | ForEach-Object -process{
    if ($_ -ne $null)
    {
        [System.Windows.Forms.MessageBox]::Show("$_ is Down!"," Connection Alert")
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("The requests are all suceeded!","Connection Alert")
    }
}
