$apiManagementName="apim-suresh09080";
$apiManagementResourceGroup="APIM-RG";
$storageAccountName="backupstorageaccount90";
$storageResourceGroup="APIM-RG";
$containerName="backups";
$blobName="ContosoBackup.apimbackupupated";

# Get Storage Account Key
$storageKey=$(az storage account keys list --resource-group $storageResourceGroup --account-name $storageAccountName --query "[0].value" -o tsv)
Write-Host $storageKey
Write-Host "backup started------------------------------------"
# Backup Azure API Management to Azure Storage
#az apim backup --name $apiManagementName --resource-group $apiManagementResourceGroup --storage-account-name $storageAccountName --storage-account-container $containerName --storage-account-key $storageKey --backup-name $blobName
Write-Host "backup completed-----------------------------------"
Write-Host "restore started -----------------------------------------------"
az apim restore --name "backup-apim9090523" --resource-group $apiManagementResourceGroup --storage-account-name $storageAccountName --storage-account-container $containerName --storage-account-key $storageKey --backup-name $blobName
#
Write-Host "restore completed -----------------------------------------------"