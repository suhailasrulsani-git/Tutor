Clear-Host

$Computername = hostname

$latestuser = Get-ChildItem -Path C:\Users | Select-Object -Property *
$latestuser = $latestuser | Select-Object Name,LastWriteTime
$latestuser = $latestuser | Where-Object { ($_.Name -notlike "*Public*") -and ($_.Name -notlike "*DefaultApp*") }
$latestuser = $latestuser | Sort-Object LastWriteTime -Descending
$latestuser = $latestuser | Select-Object -First 1
$latestuser = $latestuser.Name

$memory = Get-WmiObject -Class WIN32_OperatingSystem | Select-Object -Property *
$totalmemory = $memory.TotalVisibleMemorySize
$freememory = $memory.FreePhysicalMemory
$freememory_percent = ($freememory / $totalmemory)*100
$freememory_percent = [math]::Round($freememory_percent,2)
$freememory_percent = [string]$freememory_percent

$Process = Get-Process | Select-Object Name,CPU
$Process = $Process | Sort-Object CPU -Descending
$process = $Process | Select-Object -First 3
$process = $Process.Name[0] + ',' + $Process.Name[1] + ',' + $Process.Name[2]
$Process

$lastboottime = Get-CimInstance -ClassName win32_operatingsystem | Select-Object -Property *
$lastboottime = $lastboottime.LastBootUpTime
$lastboottime = $lastboottime.ToString("M/d/yyy h:mm:ss tt")
$lastboottime

$result = [PSCustomObject]@{
    ComputerName = $Computername
    LatestUserLogin = $latestuser
    MemoryUsage = $freememory_percent + '%'
    Top3Process = $Process
    lastBootUpTime = $lastboottime
}

$result | Format-Table -AutoSize
