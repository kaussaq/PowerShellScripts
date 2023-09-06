Connect-ExchangeOnline 

#Provide Distribution group you want to bulk-update
$dlgroup = Read-Host "Please Enter Group address"

#Import CSV of UPN's from C:\temp\users.csv and begin for-loop adding each to the distribution list above
Import-CSV /users/tombuckfield/users.csv | ForEach-Object {  
 $UPN=$_.UPN 
 Write-Progress -Activity "Adding $UPN to group… " 
 Add-DistributionGroupMember –Identity $dlgroup -Member $UPN  
 If($?)  
 {  
 Write-Host $UPN Successfully added -ForegroundColor Green 
 }  
 Else  
 {  
 Write-Host $UPN - Error occurred –ForegroundColor Red  
 }  
} 