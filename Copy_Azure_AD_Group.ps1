Connect-AzureAD

# enter login name of the first user
$user1 = Read-host "Enter username to copy from: "

# enter login name of the second user
$user2  = Read-host "Enter username to copy to: " 

# Get ObjectId based on username of user to copy from and user to copy to
$user1Obj = Get-AzureADUser -ObjectID $user1
$user2Obj = Get-AzureADUser -ObjectID $user2

#Get Groups user one is a member of
$membershipGroups = Get-AzureADUserMembership -ObjectId $user1Obj.ObjectId

Write-Host "\-- Groups available to copy from" $user1 to $user2 "--\" -ForegroundColor Yellow

#For Each group user 1 is a member of, user 2 is added to.
foreach($group in $membershipGroups) {
Write-Host $group.DisplayName
Write-Host "[!] - Adding" $user2Obj.UserPrincipalName " to " $group.DisplayName "... " -ForegroundColor Yellow -nonewline
Add-AzureADGroupMember -ObjectId $group.ObjectId -RefObjectId $user2Obj.ObjectId
Write-Host "Done"
}