Clear-Host

$Servers = @(Get-Content -Path "C:\Users\USER\Desktop\PS file\servers.txt")

foreach ($Server in $Servers) {

    $scriptBlock = {
        Function start-timer {

            param(
                [Parameter(Mandatory)]
                [int]$Seconds
            )

            for ($i = $Seconds; $Seconds -ge 1; $Seconds = $Seconds - 1) {
                Write-Host $Seconds
                Start-Sleep -Seconds 1
            }
        }
        
        Function Check-File {
            param(
                [Parameter(Mandatory)]
                [string]$Path
            )

            $Result = Test-Path -Path $Path
            if ($Result) { $true }
            else { $false }
        }

        Function Create-File {
            param(
                [Parameter(Mandatory)]
                [string]$Path
            )

            New-Item -Path $Path -ItemType "file" -Force | Out-Null
        }

        Function Add-Text {
            param(
                [Parameter(Mandatory)]
                [string]$Message,

                [Parameter(Mandatory)]
                [string]$Path
  
            )

            Add-Content -Path $Path -Value $Message
            Write-Host "Content $Message added"
        }

        $check = Check-File -Path "C:\Users\USER\Desktop\PS file\Infra\cluster.txt"

        if ($check -like "*true*") {
            Write-Host "cluster.txt exist"
            Add-Text -Path "C:\Users\USER\Desktop\PS file\Infra\cluster.txt" -Message "Suhail was here"
        }

        else {
            Write-Host "cluster.txt no exist"
            Create-File -Path "C:\Users\USER\Desktop\PS file\Infra\cluster.txt"
            Write-Host "cluster.txt created"
            Add-Text -Path "C:\Users\USER\Desktop\PS file\Infra\cluster.txt" -Message "Suhail was here"
        } 
    }

    # Create a session to remote server
    Invoke-Command -ComputerName $Server -EnableNetworkAccess -ScriptBlock $Scriptblock
}
