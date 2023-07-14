
$name = "testwithoutanything"
$rgname = "TigerTeam-TSS_AutomatedGovernance-RG"

$firewallrule = Get-AzResource -ResourceGroupName $rgname -ResourceName $name -ResourceType Microsoft.Kusto/clusters -ApiVersion 2022-12-29
$firewallruleiprange = $firewallrule.properties.allowedIpRangeList
 
$managedPE = Get-AzResource -ResourceGroupName $rgname -ResourceName $name -ResourceType Microsoft.Kusto/clusters/managedPrivateEndpoints -ApiVersion 2022-12-29
$managedPEname = $managedPE.name

 if (($firewallruleiprange -ne $null) -or ($managedPEname -ne $null))
 {
 Write-Output("The Data Explorer cluster - "+ $name + " has Firewall/Managed Private Endpoint present in the server "+ $firewallruleiprange + " "+ $managedPEname + ",so no action will be taken on this resource." )
 }
  else
    {
        Write-Output("Public network access would be disabled for the Data Explorer cluster " + $name + ". As there is no Firewall/Private Endpoint/ Managed Private Endpoint is present." )
        Update-AzKustoCluster -ResourceGroupName $rgname -Name $name -PublicNetworkAccess Disabled
    }
 
