$SharedMailbox = Read-Host "Enter name of mailbox"
$userexport = Get-MailboxPermission -Identity $SharedMailbox | Select-Object User | Export-Csv "C:\temp\existinguser.csv"
$csvData = Import-CSV "C:\temp\users.csv"
$existinguser = Import-Csv "C:\temp\existinguser.csv"

$comparison = Compare-Object -ReferenceObject $existinguser.user -DifferenceObject $csvData.UPN

$permissionThere = $comparison | Where-Object {$_.SideIndicator -eq "<="} | Select-Object InputObject | ConvertFrom-String 
#$permissionThere1 = $permissionThere | Where-Object {$_.SideIndicator -contains "*@bluestone*"}
$permissionNeeded = $comparison | Where-Object {$_.SideIndicator -eq "=>"} | Select-Object InputObject | ConvertFrom-String
#$permissionNeeded1 = $permissionNeeded | Where-Object {$_.SideIndicator -contains "*@bluestone*"}

Foreach ($user in $permissionThere){
    $output = Get-Mailbox $user
    $output
}