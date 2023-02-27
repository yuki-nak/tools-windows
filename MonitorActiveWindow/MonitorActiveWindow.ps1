$code = @'
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern IntPtr GetWindowThreadProcessId(IntPtr hwnd, out int ProcessId);
'@

Add-Type $code -Namespace Win32
$myPid = [IntPtr]::Zero;

while(1)
{
    $hwnd = [Win32.Utils]::GetForegroundWindow()
    $null = [win32.Utils]::GetWindowThreadProcessId($hwnd, [ref] $myPid)
    $process = Get-Process | Where-Object ID -eq $myPid

    $status = @{
        "Date" = (Get-Date -Format g);
        "User" = $env:USERNAME
        "Title" = ($process.MainWindowTitle);
        "Path" = ($process.Path);
    }

    $groupedResult += $destStatus
    New-Object -TypeName PSObject -Property $status -OutVariable destStatus
    Start-Sleep -Seconds 300 ## 5minutes for each
}

$log = $groupedResult | Export-Csv ".\/$env:ComputerName_AW.log" -Append -NoTypeInformation -Encoding Default

exit