Connect-ExchangeOnline 

#Provide Shared Mailbox you want to bulk-update
$SharedMailbox = Read-Host "Please Enter Shared Mailbox address"

#Import CSV of UPN's from C:\temp\users.csv and begin for-loop adding each to the distribution list above
Import-CSV 'C:\temp\users.csv' | ForEach-Object {  
 $UPN=$_.UPN 
 Write-Progress -Activity "Adding $UPN to group… " 
 Add-DistributionGroupMember –Identity $SharedMailbox -Member $UPN  
 If($?)  
 {  
 Write-Host $UPN Successfully added -ForegroundColor Green 
 }  
 Else  
 {  
 Write-Host $UPN - Error occurred –ForegroundColor Red  
 }  
} 