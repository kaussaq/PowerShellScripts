Connect-ExchangeOnline

#Enter UPN of Email you wish to list the access they have
$UPN = Read-Host "Enter Email you wish to see the access list to"

#List all access user mentioned above has access to read.
Get-EXOMailbox -ResultSize Unlimited | Get-EXOMailboxPermission -Identity $_.Identity | Where-Object {$_.User -eq $UPN}