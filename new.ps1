param (
    [string]$ResourceGroupName = 'demo1',
    [string]$Location = 'eastus',
    [string]$StorageAccountName = 'staoo089000',
    [string]$StorageSkuName = 'Standard_LRS',
    [string]$StorageKind = 'StorageV2',
    [bool]$StorageAllowBlobPublicAccess = $True,
    [bool]$StorageAllowSharedAccessKeys = $True,
    [string]$StoragePublicNetworkAccess = 'Enabled',
    [string]$StorageAccessTier = 'Cool',
    [string]$MinTlsVersion = 'TLS1_2',
    [hashtable]$Tags = @{Application = "value0"; key1 = 'test'; key2 = "value2" },
    [string]$CdnSku = 'Standard_Microsoft',
    [string]$CdnProfileName = 'cdndemo009',
    [string]$LogWorkspaceName = 'logana001',
    [string]$AksName = 'aks0001',
    [string]$NetworkPlugin = 'azure',
    [string]$NodeVmSetType = 'AvailabilitySet',
    [string]$NodeOsDiskSize = '128',
    [string]$NodeVmSize = 'Standard_B2s',
    [string]$NodeCount = '1',
    [string]$NodeMaxPodCount = '200'
       

)


## #Creating new resource group

Write-Host 'creating resource group **************************************'
try {
    Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction Stop
}
catch {
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Tag $Tags
}

Write-Host ' complated resource group creation ***************************'

#Creating storage account
Write-Host 'creating storage account ************************************'
try {
    Get-AzStorageAccount -Name $StorageAccountName  -ResourceGroupName $ResourceGroupName -ErrorAction Stop
}
catch {
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
    Write-Host 'sucessfully created storage account *************************'
}
try {
    Get-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name $LogWorkspaceName -ErrorAction Stop
}
catch {
    Write-Host 'creating loganalytics work space ****************************'
    New-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName `
        -Name $LogWorkspaceName `
        -Location $Location `
        -Sku pergb2018 
    Write-Host 'sucessfully created loganalytics work space ****************************'
    Write-Host 'Creating CDN profile ****************************'
}
try {
    Get-AzCdnProfile -ResourceGroupName $ResourceGroupName -Name $CdnProfileName -ErrorAction Stop
}
catch {
    New-AzCdnProfile -Name $CdnProfileName `
        -ResourceGroupName $ResourceGroupName `
        -Location $Location `
        -SkuName $CdnSku `
        -Tag $Tags 
    Write-Host 'Completed  CDN profile creation *************************** '
    #creatig the aks cluster 
}
try {
    Get-AzAksCluster -ResourceGroupName $ResourceGroupName -Name $AksName -ErrorAction Stop
}
catch {
    Write-Host 'creating aks cluster *******************************' 
                
    New-AzAksCluster -Name $AksName `
        -ResourceGroupName $ResourceGroupName `
        -Location $Location `
        -Tag $Tags `
        -EnableManagedIdentity `
        -NetworkPlugin $NetworkPlugin `
        -NodeVmSetType $NodeVmSetType  `
        -NodeOsDiskSize $NodeOsDiskSize `
        -NodeVmSize $NodeVmSize `
        -NodeCount $NodeCount `
        -NodeMaxPodCount $NodeMaxPodCount `
        -ServiceCidr 10.0.0.0/16 `
        -DnsServiceIP 10.0.0.10 `
        -DockerBridgeCidr 172.17.0.1/16 
                  

    Write-Host 'completed aks cluster creation ***********************************'
}
#-WorkspaceResourceId $WorkspaceResourceId `
# -AddOnNameToBeEnabled Monitoring 
