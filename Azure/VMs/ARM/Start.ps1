$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
$vm = @('vm1','vm2','vm3')
foreach ($v in $vm) { Start-AzureRmVM -ResourceGroupName 'rg' -Name $v }