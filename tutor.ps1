cls

$Name = $null
$x = $null
$y = $null
$numbers = $null
$item = $null

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
$x = [int]$x
$x + $x

"`n"

# float
[int]$y = 5.65678990
$y
$y + $y

[double]$y = 5.65678990
$y
$y + $y

[float]$y = 5.65678990
$y
$y + $y
$y = [math]::Round($y, 2)
$y

"`n"

# array
[array]$numbers = @('1','2','3')
$numbers.GetType()
$numbers[0]
$numbers[1]
$numbers[2]
[int]$numbers[0] + [int]$numbers[2]
foreach ($item in $numbers) {
    Write-host 'This is ' $item
}

"`n"

# select-object
Get-process | Select-Object Name,cpu | Select-Object -First 3 | Format-Table -AutoSize
