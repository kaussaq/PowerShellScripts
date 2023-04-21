Connect-ExchangeOnline

#Access Rights required for users in C:\temp\users.csv
$AR = Read-Host "Please Enter Access Rights Required"

#UPN of Calendar you're giving access to. 
$Calendar = Read-Host "Enter Full Address of Calendar" 

#Import CSV and begin for-loop adding each user into calendar provided above
Import-Csv C:\temp\users.csv | ForEach-Object {
Add-MailboxFolderPermission $Calendar":\Calendar" -User $_.UPN -AccessRights $AR
 If($?)  
 {  
 Write-Host $UPN Successfully added -ForegroundColor Green 
 }  
 Else  
 {  
 Write-Host $UPN - Error occurred –ForegroundColor Red  
 }  
} 