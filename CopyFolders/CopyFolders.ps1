$ErrorActionPreference = "silentlycontinue"

### Global Variables ###
$logDir = "$PSSCriptRoot\logs"
$logDirName = Get-Date -Format "yyyy-MM-dd-HHmm"
$list = Import-Csv $PSSCriptRoot\copytarget.csv -Encoding Default

### For Testing ###
#$list = Import-Csv $PSSCriptRoot\t_copytarget.csv -Encoding Default

### Main ###
mkdir $logDir\$logDirName

foreach ($item in $list)
{
    $id = $($item.id)
    $src = $(item.source)
    $dest = $($item.destination)

    robocopy $rsc $dest /E /PURGE /DCOPY:DAT /R:3 /W:3 /LOG+ $logDir\$logDirname\$id.log
    
    $logTime = Get-Date -Format "yyyy-MM-dd-HHmm"
    Add-Content "$logDir\logDirName\Summary.log" "$logTime  `t `: Copy Finished `t $id `t $dest"
}