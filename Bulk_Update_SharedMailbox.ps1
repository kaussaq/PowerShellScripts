Connect-ExchangeOnline

#Provide Shared Mailbox you want to bulk-update
$SharedMailbox = Read-Host "Please enter Shared Mailbox address:"
$AccessRights = Read-Host "Please enter Access rights:"

#Import CSV of UPN's from C:\temp\users.csv and begin for-loop adding each to the distribution list above
Import-Csv C:\temp\users.csv | ForEach-Object {
    $UPN=$_.UPN
    Write-Progress -Activity "Adding $UPN to Mailbox… "
    Add-MailboxPermission -Identity $SharedMailbox -User $UPN -AccessRights $AccessRights
    If($?)  
    {  
    Write-Host $UPN Successfully added -ForegroundColor Green 
    }  
    Elseif($? -ne "True"){
    Set-MailboxPermission -Identity $SharedMailbox -User $UPN -AccessRights $AccessRights
    Write-Host $UPN Successfully updated -ForegroundColor Green
    }
    Else  
    {  
    Write-Host $UPN Error occurred -ForegroundColor Red
    }  
} 