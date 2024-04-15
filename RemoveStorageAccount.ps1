
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)][string] $ResourceGroupName,
    [Parameter(Mandatory = $true)][string] $Location,
    [Parameter(Mandatory = $true)][string] $StorageAccountName
)

class RemoveAzureStorageAccount {
    [string] $ResourceGroupName
    [string] $Location
    [string] $StorageAccountName

    RemoveAzureStorageAccount([string]$ResourceGroupName, [string]$Location, [string]$StorageAccountName) {
        $this.ResourceGroupName = $ResourceGroupName
        $this.Location = $Location
        $this.StorageAccountName = $StorageAccountName
    }

    [void] RemoveStorageAccount() {
        if (-not (Get-Module -ListAvailable -Name Az.Storage)) {
            Write-Error "Azure storage module  is not installed"
            return
        }
        try {
       
            $storageaccount = Get-AzStorageAccount -ResourceGroupName $this.ResourceGroupName -Name $this.StorageAccountName -ErrorAction Stop
            
            if ($storageaccount) {
                Write-Host "Storage account $($this.StorageAccountName)  exists!"
                Remove-AzStorageAccount -ResourceGroupName $this.ResourceGroupName -Name $this.StorageAccountName -Force
                Write-Host "Storage account $($this.StorageAccountName)  removed successfully!"
            }
            else {
                Write-Host "Storage account $($this.StorageAccountName)  doesn't exists!"
            }
        }
        catch {
            Write-Host "An error occurred: $_.Exception.Message"
        }
    }


}

$storageAccount = [RemoveAzureStorageAccount]:: new($ResourceGroupName, $Location, $StorageAccountName)
$storageAccount.RemoveStorageAccount();