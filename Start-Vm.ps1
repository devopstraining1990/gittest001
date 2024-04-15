
Connect-AzAccount

Set-AzContext -SubscriptionId "2a5df3c8-54b6-4537-999d-c28f7b920d0d"

$ResourceGroupName ="new-vm-rg"
$VmName="vmsuresh009"

Start-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

