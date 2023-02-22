Write-Host "Create toal 10GB files."
$dir = (Read-Host "Please input the destination path")

# Create Top Directory
if (Test-Path $dir)
{
    Write-Host "The directory is already exitsted!!"
}
else
{
    New-Item $dir -ItemType Directory
}

# Create Dummy Files
for($i=1; $i-lt 101; $i++)
{
    for ($j =1; $j-lt 101; $j++){
    $randomBin = New-Object byte[] (1024*1024)
    (New-Object random).NextBytes($randomBin)
    [IO.File]::WriteAllBytes("$dir\dummy_$i\dammy_$j.dat", $randomBin)
    }
}