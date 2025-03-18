# Error handling
$ErrorActionPreference = "Stop"

try {
    # Create OU for employees
    # Create a log file
    $logFile = "C:/Users/Administrator/Documents/AD-Lab-AutomationProject/automation.log"
    function Log-Message {
        param (
            [string]$message
        )
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logEntry = "$timestamp - $message"
        Add-Content -Path $logFile -Value $logEntry
    }

    # Create OU for employees
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "employees"})) {
        New-ADOrganizationalUnit -Name "employees" -Path "DC=DinsLabDomain,DC=local"
        Log-Message "OU 'employees' created."
    } else {
        Write-Host "OU 'employees' already exists."
        Log-Message "OU 'employees' already exists."
    }

    # Create sub OU for departments
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "IT"})) {
        New-ADOrganizationalUnit -Name "IT" -Path "OU=employees,DC=DinsLabDomain,DC=local"
        Log-Message "OU 'IT' created."
    } else {
        Write-Host "OU 'IT' already exists."
        Log-Message "OU 'IT' already exists."
    }

    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "HR"})) {
        New-ADOrganizationalUnit -Name "HR" -Path "OU=employees,DC=DinsLabDomain,DC=local"
        Log-Message "OU 'HR' created."
    } else {
        Write-Host "OU 'HR' already exists."
        Log-Message "OU 'HR' already exists."
    }

    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "Finance"})) {
        New-ADOrganizationalUnit -Name "Finance" -Path "OU=employees,DC=DinsLabDomain,DC=local"
        Log-Message "OU 'Finance' created."
    } else {
        Write-Host "OU 'Finance' already exists."
        Log-Message "OU 'Finance' already exists."
    }

    # Create OU for disabled or deprovisioned users
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "Disabled Users"})) {
        New-ADOrganizationalUnit -Name "Disabled Users" -Path "DC=DinsLabDomain,DC=local"
        Log-Message "OU 'Disabled Users' created."
    } else {
        Write-Host "OU 'Disabled Users' already exists."
        Log-Message "OU 'Disabled Users' already exists."
    }

    # Verify OU creation
    Get-ADOrganizationalUnit -Filter {Name -like "*"} | Select-Object Name, DistinguishedName | ForEach-Object {
        Log-Message "OU: $($_.Name) - $($_.DistinguishedName)"
    }

    # Create security groups for each department
    if (-not (Get-ADGroup -Filter {Name -eq "IT-Admins"})) {
        New-ADGroup -name "IT-Admins" -GroupScope Global -GroupCategory Security -Path "OU=IT,OU=employees,DC=DinsLabDomain,DC=local"
        Log-Message "Group 'IT-Admins' created."
    } else {
        Write-Host "Group 'IT-Admins' already exists."
        Log-Message "Group 'IT-Admins' already exists."
    }

    if (-not (Get-ADGroup -Filter {Name -eq "HR-Staff"})) {
        New-ADGroup -name "HR-Staff" -GroupScope Global -GroupCategory Security -Path "OU=HR,OU=employees,DC=DinsLabDomain,DC=local"
        Log-Message "Group 'HR-Staff' created."
    } else {
        Write-Host "Group 'HR-Staff' already exists."
        Log-Message "Group 'HR-Staff' already exists."
    }

    if (-not (Get-ADGroup -Filter {Name -eq "Finance-Team"})) {
        New-ADGroup -name "Finance-Team" -GroupScope Global -GroupCategory Security -Path "OU=Finance,OU=employees,DC=DinsLabDomain,DC=local"
        Log-Message "Group 'Finance-Team' created."
    } else {
        Write-Host "Group 'Finance-Team' already exists."
        Log-Message "Group 'Finance-Team' already exists."
    }

    # Verify group creation
    Get-ADGroup -Filter { Name -like "*-Admins" -or Name -like "*-Staff" -or Name -like "*-Team" } | Select-Object Name, DistinguishedName | ForEach-Object {
        Log-Message "Group: $($_.Name) - $($_.DistinguishedName)"
    }

    # Create users for each department
    if (-not (Get-ADUser -Filter {SamAccountName -eq "jdoe"})) {
        New-ADUser -Name "John Doe" -GivenName "John" -Surname "Doe" -SamAccountName "jdoe" -UserPrincipalName "jdoe@DinsLabDomain.local" -Path "OU=IT,OU=employees,DC=DinsLabDomain,DC=local" -AccountPassword (ConvertTo-SecureString "Str0ngP@ssw0rd!" -AsPlainText -Force) -Enabled $true
        Log-Message "User 'jdoe' created."
    } else {
        Write-Host "User 'jdoe' already exists."
        Log-Message "User 'jdoe' already exists."
    }

    if (-not (Get-ADUser -Filter {SamAccountName -eq "jsmith"})) {
        New-ADUser -Name "Jane Smith" -GivenName "Jane" -Surname "Smith" -SamAccountName "jsmith" -UserPrincipalName "jsmith@DinsLabDomain.local" -Path "OU=HR,OU=employees,DC=DinsLabDomain,DC=local" -AccountPassword (ConvertTo-SecureString "Str0ngP@ssw0rd!" -AsPlainText -Force) -Enabled $true
        Log-Message "User 'jsmith' created."
    } else {
        Write-Host "User 'jsmith' already exists."
        Log-Message "User 'jsmith' already exists."
    }

    if (-not (Get-ADUser -Filter {SamAccountName -eq "mjohnson"})) {
        New-ADUser -Name "Mike Johnson" -GivenName "Mike" -Surname "Johnson" -SamAccountName "mjohnson" -UserPrincipalName "mjohnson@DinsLabDomain.local" -Path "OU=Finance,OU=employees,DC=DinsLabDomain,DC=local" -AccountPassword (ConvertTo-SecureString "Str0ngP@ssw0rd!" -AsPlainText -Force) -Enabled $true
        Log-Message "User 'mjohnson' created."
    } else {
        Write-Host "User 'mjohnson' already exists."
        Log-Message "User 'mjohnson' already exists."
    }

    # Add users to their respective department groups
    Add-ADGroupMember -Identity "IT-Admins" -Members "jdoe"
    Log-Message "User 'jdoe' added to 'IT-Admins'."
    Add-ADGroupMember -Identity "HR-Staff" -Members "jsmith"
    Log-Message "User 'jsmith' added to 'HR-Staff'."
    Add-ADGroupMember -Identity "Finance-Team" -Members "mjohnson"
    Log-Message "User 'mjohnson' added to 'Finance-Team'."

    # Verify user creation and group membership
    Get-ADUser -SearchBase "OU=employees,DC=DinsLabDomain,DC=local" -Filter * | Select-Object Name, SamAccountName, DistinguishedName | ForEach-Object {
        Log-Message "User: $($_.Name) - $($_.SamAccountName) - $($_.DistinguishedName)"
    }

    # Enable the account
    Enable-ADAccount -Identity "jdoe"
    Log-Message "Account 'jdoe' enabled."
    Enable-ADAccount -Identity "jsmith"
    Log-Message "Account 'jsmith' enabled."
    Enable-ADAccount -Identity "mjohnson"
    Log-Message "Account 'mjohnson' enabled."
} catch {
    Write-Error "An error occurred: $_"
    Log-Message "An error occurred: $_"
}