
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)][string] $ResourceGroupName,
    [Parameter(Mandatory = $true)][string] $Location,
    [Parameter(Mandatory = $true)][string] $StorageAccountName,
    [string] $Kind = "StorageV2",
    [string] $SkuName = "Standard_LRS"
)

class AzureStorageAccount {
    [string] $ResourceGroupName
    [string] $Location
    [string] $StorageAccountName
    [string] $Kind
    [string] $SkuName

    AzureStorageAccount([string]$ResourceGroupName, [string]$Location, [string]$StorageAccountName, [string]$Kind, [string]$SkuName) {
        $this.ResourceGroupName = $ResourceGroupName
        $this.Location = $Location
        $this.StorageAccountName = $StorageAccountName
        $this.Kind = $Kind
        $this.SkuName = $SkuName
    }

    [void] CreateStorageAccount() {
        if (-not (Get-Module -ListAvailable -Name Az.Storage)) {
            Write-Error "Azure storage module  is not installed"
            return
        }
        try {
            $resourceGroup = Get-AzResourceGroup -Name $this.ResourceGroupName -ErrorAction SilentlyContinue

            if ($resourceGroup) {
                Write-Host "Resource group '$($this.ResourceGroupName)' exists."
            }
            else {
                New-AzResourceGroup -Name $this.ResourceGroupName `
                    -Location $this.Location 
                Write-Host "Resource Group $($this.ResourceGroupName)) created successfully"
            }
            $storageaccount = Get-AzStorageAccount -ResourceGroupName $this.ResourceGroupName -Name $this.StorageAccountName -ErrorAction Stop
            if ($storageaccount) {
                Write-Host "Storage account $($this.StorageAccountName) already exists!"
            }
            else {
                New-AzStorageAccount `
                    -ResourceGroupName $this.ResourceGroupName `
                    -Location $this.Location `
                    -Name $this.StorageAccountName `
                    -Kind $this.Kind `
                    -SkuName $this.SkuName
            
                Write-Host "Storage account $($this.StorageAccountName) Created sucessfully"
            }
        }
        catch {
            Write-Host "An error occurred: $_.Exception.Message"
        }
    }


}

$storageAccount = [AzureStorageAccount]:: new($ResourceGroupName, $Location, $StorageAccountName, $Kind, $SkuName)
$storageAccount.CreateStorageAccount();