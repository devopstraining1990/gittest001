param (
   [Parameter()]
   [string] $ResourceGroupName,
   [Parameter(Mandatory=$true,ParameterSetName='eastus')]
   [string] $Location,
   [Parameter()]
   [string] $StorageAccountName,
   [Parameter()]
   [string] $StorageSkuName,
   [Parameter()]
   [string] $StorageKind,
   [Parameter()]
   [bool] $StorageAllowBlobPublicAccess,
   [Parameter()]
   [bool] $StorageAllowSharedAccessKeys,
   [Parameter()]
   [string] $StoragePublicNetworkAccess,
   [Parameter()]
   [string] $StorageAccessTier,
   [Parameter()]
   [hashtable] $Tags
   )
   


#Creating new resource group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Tag $Tags

#Creating storage account
New-AzStorageAccount -ResourceGroupName $ResourceGroupName `
                     -Name $StorageAccountName `
                     -Location $Location `
                     -AccessTier $StorageAccessTier `
                     -SkuName $StorageSkuName `
                     -Kind $StorageKind `
                     -AllowBlobPublicAccess $StorageAllowBlobPublicAccess `
                     -AllowSharedKeyAccess $StorageAllowSharedAccessKeys `
                     -PublicNetworkAccess $StoragePublicNetworkAccess `
                     -MinimumTlsVersion TLS1_2 `
                     -Tag $Tags
