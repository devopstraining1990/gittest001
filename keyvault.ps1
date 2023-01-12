$resourcegroup ="rg-akv"
$location = "centralus"
$keyvaultName ="akvcentralus01"

if($(az group exists -n $resourcegroup) -eq $false)
{
    Write-Host  -ForegroundColor  Magenta "creating new resource group"
    az group create -n $resourcegroup -l $location
}else {
    
    Write-Host  -ForegroundColor  Magenta $resourcegroup "resource group already exists"
}

$akv =$(az keyvault show -n $keyvaultName -g $resourcegroup -o tsv --query "name")
if(($akv) -eq $keyvaultName)
{
    Write-Host  -ForegroundColor  Magenta $akv "keyvault is already exists"
}else {
    Write-Host  -ForegroundColor  Magenta "creating new keyvault"
    az keyvault create -g $resourcegroup -l $location --sku standard -n $keyvaultName
}

#creating access policies for aks cluster managed identity
az keyvault set-policy --name akvcentralus01 --resource-group rg-akv --object-id f --secret-permissions get list set --certificate-permissions list get --key-permissions list get
