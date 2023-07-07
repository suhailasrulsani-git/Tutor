Clear-Host

[array]$server = @("DESKTOP-9CKGQK2","DESKTOP-9CKGQK2")

$result = foreach ($item in $server) {
    Invoke-Command -ComputerName 'DESKTOP-9CKGQK2' -EnableNetworkAccess -ScriptBlock {
        $ComputerName = hostname
$path = "C:\Users"

$user = Get-ChildItem -Path $path | Select-Object -Property *
$user = $user | Select-Object Name,LastWriteTime
$user = $user | Sort-Object LastWriteTime -Descending
$user = $user | Where-Object { ($_.Name -notlike "Public") -and ($_.Name -notlike "*Default*")}
$user = $user | Select-Object -First 1
$latestuserlogin = $user.Name

$memory = Get-WmiObject -Class WIN32_OperatingSystem | Select-Object -Property *
$totalmemory = $memory.TotalVisibleMemorySize
$freememory = $totalmemory - $memory.FreePhysicalMemory
$memoryusage = ($freememory / $totalmemory) * 100
$memoryusage = [math]::Round($memoryusage, 2)
$memoryusage = [string]$memoryusage

$highprocess = Get-Process | Select-Object ProcessName, CPU
$highprocess = $highprocess | Sort-Object CPU -Descending
$highprocess = $highprocess | Select-Object -First 3
$highprocess = $highprocess.ProcessName[0] + ',' + $highprocess.ProcessName[1] + ',' + $highprocess.ProcessName[2]

$lastBootUpTime = Get-CimInstance -ClassName win32_operatingsystem | select-object lastbootuptime
$lastBootUpTime = $lastBootUpTime.lastbootuptime
$lastBootUpTime = [datetime]$lastBootUpTime
$lastBootUpTime = $lastBootUpTime.ToString("M/d/yyy h:mm:ss tt")

    [PSCustomObject]@{
    ComputerName = $ComputerName
    LatestUserLogin = $latestUserLogin
    MemoryUsage = $memoryusage + ' %'
    Top3Process = $highprocess
    lastBootUpTime = $lastBootUpTime
}
    }
}

$result | Format-Table -AutoSize
$result | Export-Excel -Path "C:\Users\USER\Desktop\psmodule\result.xlsx" -AutoSize -TableName "result" -WorksheetName "result"

$convertParams = @{
        PreContent = "<p>Hi</p>
        <p>Computer Report:</p>"

        Body       = @"
        <Title>Disk Space Report</Title>
        <style>
        body { background-color:#ffffff;
        font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
        font-size:10pt; }
        
        table 
{
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    font-size: 12px;
    #width: 100%;
}
td, th
{
	#border: 1px solid #ddd;
    border: 2px solid black;
	padding-top: 0;
    padding-bottom: 0;
}
tr:nth-child(even) {background-color: #f2f2f2;}
tr:hover {background-color: #ddd;}
th
{
    padding-top: 0;
    padding-bottom: 0;
    text-align: left;
    background-color: #4CAF50;
    color:white;
}
        </style>
"@
    }

$result | ConvertTo-AdvHTML @convertParams | Out-File "C:\Users\USER\Desktop\psmodule\result.html" -Force
