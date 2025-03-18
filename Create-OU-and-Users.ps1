#create ou for employees
New-ADOrganizationalUnit -Name "employees" -Path "DC=DinsLabDomain,DC=local"
#create sub ou for departments
New-ADOrganizationalUnit -Name "IT" -Path "OU=employees,DC=DinsLabDomain,DC=local"
New-ADOrganizationalUnit -Name "HR" -Path "OU=employees,DC=DinsLabDomain,DC=local"
New-ADOrganizationalUnit -Name "Finance" -Path "OU=employees,DC=DinsLabDomain,DC=local"
#create ou for disabled or deprovisioned users
New-ADOrganizationalUnit -Name "Disabled Users" -Path "DC=DinsLabDomain,DC=local"
#verify ou creation
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
#create security groups for each department
New-ADGroup -name "IT-Admins" -GroupScope Global -GroupCategory Security -Path "OU=IT,OU=employees,DC=DinsLabDomain,DC=local"
New-ADGroup -name "HR-Staff" -GroupScope Global -GroupCategory Security -Path "OU=HR,OU=employees,DC=DinsLabDomain,DC=local"
New-ADGroup -name "Finance-Team" -GroupScope Global -GroupCategory Security -Path "OU=Finance,OU=employees,DC=DinsLabDomain,DC=local"
#verify group creation
Get-ADGroup -Filter * | Select-Object Name, DistinguishedName
#create users for each department
New-ADUser -Name "John Doe" -GivenName "John" -Surname "Doe" -SamAccountName "jdoe" -UserPrincipalName "jdoe@DinsLabDomain.local" -Path "OU=IT,OU=employees,DC=DinsLabDomain,DC=local" -AccountPassword (ConvertTo-SecureString "Str0ngP@ssw0rd!" -AsPlainText -Force) -Enabled $true
New-ADUser -Name "Jane Smith" -GivenName "Jane" -Surname "Smith" -SamAccountName "jsmith" -UserPrincipalName "jsmith@DinsLabDomain.local" -Path "OU=HR,OU=employees,DC=DinsLabDomain,DC=local" -AccountPassword (ConvertTo-SecureString "Str0ngP@ssw0rd!" -AsPlainText -Force) -Enabled $true
New-ADUser -Name "Mike Johnson" -GivenName "Mike" -Surname "Johnson" -SamAccountName "mjohnson" -UserPrincipalName "mjohnson@DinsLabDomain.local" -Path "OU=Finance,OU=employees,DC=DinsLabDomain,DC=local" -AccountPassword (ConvertTo-SecureString "Str0ngP@ssw0rd!" -AsPlainText -Force) -Enabled $true
#add users to their respective department groups
Add-ADGroupMember -Identity "IT-Admins" -Members "jdoe"
Add-ADGroupMember -Identity "HR-Staff" -Members "jsmith"
Add-ADGroupMember -Identity "Finance-Team" -Members "mjohnson"
#verify user creation and group membership
Get-ADUser -Filter * | Select-Object Name, SamAccountName, DistinguishedName
#enable the account
Enable-ADAccount -Identity "jdoe"
Enable-ADAccount -Identity "jsmith"
Enable-ADAccount -Identity "mjohnson"