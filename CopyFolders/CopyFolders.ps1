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
    
}