Connect-ExchangeOnline 

#Specify email address in question.
$UPN= Read-Host "Enter email address to see what is forwarding to it" 

#Convert UPN to Identity.
$RecipientIdentity=(Get-Recipient $UPN ).Identity  

#List all mailboxes forwarded to identity listed above.
Get-Mailbox | where {($_.ForwardingAddress -eq $RecipientIdentity) -or ($_.ForwardingSMTPAddress -match $UPN) } | select Name, Alias 