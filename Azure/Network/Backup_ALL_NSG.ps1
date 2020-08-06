#Add-AzureRmAccount
$subscriptions = Get-AzureRmSubscription
$exportPath = 'C:\temp'

foreach($sub in $subscriptions) {

    Set-AzureRmContext -SubscriptionId $sub
    $nsgs = Get-AzureRmNetworkSecurityGroup
    $folder = (Get-AzureRmSubscription -SubscriptionId "$($sub)").Name

    #backup nsgs to csv
    Foreach ($nsg in $nsgs) {
        New-Item -ItemType file -Path "$exportPath\$folder\$($nsg.Name).csv" -Force
        $nsgRules = $nsg.SecurityRules
        foreach ($nsgRule in $nsgRules) {
            $nsgRule | Select-Object Name,Description,Priority,@{Name='SourceAddressPrefix';Expression={[string]::join(",", ($_.SourceAddressPrefix))}},@{Name='SourcePortRange';Expression={[string]::join(",", ($_.SourcePortRange))}},@{Name='DestinationAddressPrefix';Expression={[string]::join(",", ($_.DestinationAddressPrefix))}},@{Name='DestinationPortRange';Expression={[string]::join(",", ($_.DestinationPortRange))}},Protocol,Access,Direction `
            | Export-Csv "$exportPath\$folder\$($nsg.Name).csv" -NoTypeInformation -Encoding ASCII -Append
        }
    }
}