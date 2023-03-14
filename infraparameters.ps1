 $dev_paramaters = @{
   #Name of the resource group
   ResourceGroupName = 'demo2'
   #Location of the resource 
   Location = 'eastus'
   #Name of the storage account
   StorageAccountName='staoo0898'
   #Storage account sku type
   StorageSkuName = 'Standard_LRS'
   #Storage account kind
   StorageKind = 'StorageV2'
   #Allowing the storage blob public access
   StorageAllowBlobPublicAccess = $True
   #Allowing the storage account shared access keys
   StorageAllowSharedAccessKeys = $True
   #Enabling the storage public access
   StoragePublicNetworkAccess = 'Enabled'
   #Storage account tier
   StorageAccessTier = 'Cool'
   #tags of the storage account
   Tags = @{key0="value0";key1=$null;key2="value2"}
  }
