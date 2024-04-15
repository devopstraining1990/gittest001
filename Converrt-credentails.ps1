$username = "azureadmin"
$password = "harshini94u@0523" | ConvertTo-SecureString -AsPlainText -Force

#method1
[pscredential]::new($username,$password)

#Method2
$newobj1 = New-Object System.Management.Automation.PSCredential($username, $password)
Write-Debug $newobj1


# Get Azure login details
# Get Azure login details
$azureUsername = Read-Host -Prompt "Enter your Azure username"
$azurePassword = Read-Host -Prompt "Enter your Azure password" -AsSecureString

# Convert secure string password to plain text
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($azurePassword))

# Create a PSCredential object
$credential = New-Object System.Management.Automation.PSCredential ($azureUsername, $azurePassword)

# Connect to Azure using the provided credentials
Connect-AzAccount -Credential $credential

# List Azure subscriptions to verify the connection
Get-AzSubscription