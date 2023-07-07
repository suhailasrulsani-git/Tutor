cls

$Name = $null
$x = $null

# print
Write-Host 'My Name is Suhail'
Write-Host 'My Name is Suhail' -ForegroundColor Green
Write-Host 'My Name is Suhail' -ForegroundColor Green -BackgroundColor red
Write-Information -MessageData test

"`n"

# variable string
$Name = 'Suhail'
$Name.GetType().Name
$Name.Length
$Name.Replace("h","b")

"`n"

#variable int
$x = "2"
$x + $x
#$x = [int]$x
#$x + $x
