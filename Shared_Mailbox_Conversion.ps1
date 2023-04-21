Connect-ExchangeOnline

#get name of mailbox to convert

$mailbox = Read-Host -Prompt "Which Mailbox do you want to convert? "

#convert mailbox to shared

Set-Mailbox -Identity $mailbox -Type Shared

#Check if anyone needs members

$yesno = Read-Host -Prompt "Does anyone need access to this mailbox? (y/n)"

#while yes/no is yes keep asking if anymore needed

while ($yesno = y){

$mailbox = Read-Host -Prompt "Who needs access to this mailbox?"

Add-mailboxpermission - Identity $mailbox -User $member -AccessRights FullAccess

$yesno = Read-Host -Prompt "anymore? (y/n)"

}
