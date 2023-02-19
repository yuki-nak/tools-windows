$date = get-date -Format "yyyy-mm-dd"
$src = "src¥*.csv"
$dest = "dest¥$date.csv"
$importFiles = Get-ChildItem $src | foreach {Import-Csv $_}
$importFiles | Export-Csv -NoTypeInformation $dest