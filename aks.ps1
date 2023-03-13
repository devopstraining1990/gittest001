az account show

$RG_NAME = 'DEMO-KUB-API-DEV'
$LOCATION = 'eastus'
$VNET_NAME = 'DEMO-KUB-API-VNET'
$SUBNET_NAME = 'DEMO-KUB-API-SNET'
 
az group create --name $RG_NAME --location $LOCATION

az network vnet create --name $VNET_NAME `
--resource-group $RG_NAME `
--address-prefixes 10.0.72.0/22 `
--subnet-name $SUBNET_NAME `
--subnet-prefixes 10.0.72.0/22

$VNET_ID=$(az network vnet show --resource-group $RG_NAME --name $VNET_NAME --query id -o tsv )

echo $VNET_ID

$AKS_VNET_SUBNET_DEFAULT_ID=$(az network vnet subnet show --resource-group $RG_NAME --vnet-name $VNET_NAME --name $SUBNET_NAME --query id -o tsv)

echo $AKS_VNET_SUBNET_DEFAULT_ID

$AKS_LOGANALYTICS_WORKSPACE_NAME = 'DEMO-KUB-API-DEV-LOGANALYTICS-WORKSPACE'
$LOGANALYTICS_SKU = 'PerGB2018'

az monitor log-analytics workspace create --resource-group $RG_NAME `
--workspace-name $AKS_LOGANALYTICS_WORKSPACE_NAME `
--location $LOCATION `
--sku $LOGANALYTICS_SKU


$WORKSPCE_RESOURCE_ID=$(az monitor log-analytics workspace show --resource-group $RG_NAME `
--workspace-name $AKS_LOGANALYTICS_WORKSPACE_NAME `
--query id `
-o tsv)


echo $WORKSPCE_RESOURCE_ID

$AKS_CLUSTER_NAME = 'DEMO-KUB-API-DEV'
$AKS_CLUSTER_DNS_NAME=$AKS_CLUSTER_NAME+'-dns'

az aks get-versions --location eastus 

# --kubernetes-version 1.24.9 `

az aks create --resource-group $RG_NAME `
--name $AKS_CLUSTER_NAME `
--location $LOCATION `
--dns-name-prefix $AKS_CLUSTER_DNS_NAME `
--enable-managed-identity `
--vm-set-type AvailabilitySet `
--node-count 1 `
--network-plugin 'azure' `
--max-pods 110 `
--service-cidr 10.0.0.0/16 `
--dns-service-ip 10.0.0.10 `
--docker-bridge-address 172.17.0.1/16 `
--vnet-subnet-id $AKS_VNET_SUBNET_DEFAULT_ID `
--node-osdisk-size 128 `
--node-osdisk-type 'Managed' `
--node-vm-size Standard_B2ms `
--enable-addons monitoring  `
--workspace-resource-id $WORKSPCE_RESOURCE_ID 



az aks get-credentials --resource-group DEMO-KUB-API-DEV --name DEMO-KUB-API-DEV

kubectl get ns 
