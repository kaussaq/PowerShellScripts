Connect-ExchangeOnline 

#Provide Shared Mailbox you want to bulk-update
$SharedMailbox = Read-Host "Please enter Shared Mailbox address:"
$AccessRights = Read-Host "Please enter Access rights:"

#Import CSV of UPN's from C:\temp\users.csv and begin for-loop adding each to the distribution list above
Import-CSV 'C:\temp\users.csv' | ForEach-Object {  
 $UPN=$_.UPN 
 Write-Progress -Activity "Adding $UPN to Mailbox… " 
 Add-MailboxPermission –Identity $SharedMailbox -Member $UPN -AccessRights $AccessRights
 If($?)  
 {  
 Write-Host $UPN Successfully added -ForegroundColor Green 
 }  
 Else  
 {  
 Write-Host $UPN - Error occurred –ForegroundColor Red  
 }  
} 