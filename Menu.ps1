$MainMenu = {
   Write-Host " ***************************"
   Write-Host " *           Menu          *"
   Write-Host " ***************************"
   Write-Host
   Write-Host " 1.) Get mailbox Access for a specific user"
   Write-Host " 2.) Get list of mailboxes forwarding to a specific user"
   Write-Host " 3.) Update Distribution list with entries from C:\Temp\Users.CSV (UPN needs to be stated in cell A1, then User Principal Name for each user in A2,3 etc.)"
   Write-Host " 4.) Update Calendar permissions with entries from C:\Temp\Users.CSV (UPN needs to be stated in cell A1, then User Principal Name for each user in A2,3 etc.)"
   Write-Host " 5.) Quit"
   Write-Host
   Write-Host " Select an option and press Enter: "  -nonewline
}
Clear-Host

Do {
   Clear-Host
   Invoke-Command $MainMenu
   $Select = Read-Host
   Switch ($Select){
       1{
           Connect-ExchangeOnline

           #Enter UPN of Email you wish to list the access they have
           $UPN = Read-Host "Enter Email you wish to see the access list to"
       
           #List all access user mentioned above has access to read.
           Get-EXOMailbox -ResultSize Unlimited | Get-EXOMailboxPermission -Identity $_.Identity | Where-Object {$_.User -eq $UPN}
       }
       2{
           Connect-ExchangeOnline 

           #Specify email address in question.
           $UPN = Read-Host "Enter email address to see what is forwarding to it" 
           
           #Convert UPN to Identity.
           $RecipientIdentity=(Get-Recipient $UPN ).Identity  
           
           #List all mailboxes forwarded to identity listed above.
           Get-Mailbox | Where-Object {($_.ForwardingAddress -eq $RecipientIdentity) -or ($_.ForwardingSMTPAddress -match $UPN) } | Select-Object Name, Alias
       }
       3{
           Connect-ExchangeOnline 
           
           #Provide Distribution group you want to bulk-update
           $dlgroup = Read-Host "Please Enter Group address"
       
           #Import CSV of UPN's from C:\temp\users.csv and begin for-loop adding each to the distribution list above
           Import-CSV 'C:\temp\users.csv' | ForEach-Object {  
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
       }
       4{
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
       }
       5{
           Exit
       }
   }
}
While ($Select -ne 5)