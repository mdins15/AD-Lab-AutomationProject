# Define the path to the CSV file
$csvPath = "C:\Users\Administrator\Documents\users.csv"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Define the Organizational Unit (OU) where the users will be created
$ouPath = "OU=Employees,DC=DinsLabDomain,DC=local"

# Define the initial password for new users
$initialPassword = "P@ssw0rd123"
$securePassword = ConvertTo-SecureString $initialPassword -AsPlainText -Force

# Log file path
$logFilePath = "C:\Users\Administrator\Documents\user_creation_log.txt"

# Function to log messages
function Write-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Add-Content -Path $logFilePath -Value $logMessage
}

# Process each user in the CSV file
foreach ($user in $users) {
    $missingFields = @()
    if (-not $user.FirstName) { $missingFields += "FirstName" }
    if (-not $user.LastName) { $missingFields += "LastName" }
    if (-not $user.SamAccountName) { $missingFields += "SamAccountName" }
    if (-not $user.Email) { $missingFields += "Email" }

    if ($missingFields.Count -gt 0) {
        Write-Message "Skipping user creation due to missing required fields: $($missingFields -join ', ')"
        continue
    }

    $firstName = $user.FirstName
    $lastName = $user.LastName
    $displayName = "$firstName $lastName"
    $samAccountName = $user.SamAccountName
    $userPrincipalName = $user.Email

    try {
        # Check if the user already exists in Active Directory
        $existingUser = Get-ADUser -Filter { SamAccountName -eq $samAccountName }

        if ($null -ne $existingUser) {
            Write-Message "User $samAccountName already exists in Active Directory."
            continue
        }
    } catch {
        Write-Message "Error checking if user $samAccountName exists. Error: $_"
        continue
    }

    # User does not exist, create a new user
    try {
        Write-Message "Creating user with the following details:"
        Write-Message "GivenName: $firstName"
        Write-Message "Surname: $lastName"
        Write-Message "DisplayName: $displayName"
        Write-Message "SamAccountName: $samAccountName"
        Write-Message "UserPrincipalName: $userPrincipalName"
        Write-Message "Path: $ouPath"
        Write-Message "Password: $initialPassword"

        New-ADUser -Name "$firstName $lastName" `
                   -GivenName $firstName `
                   -Surname $lastName `
                   -DisplayName $displayName `
                   -SamAccountName $samAccountName `
                   -UserPrincipalName $userPrincipalName `
                   -Path $ouPath `
                   -AccountPassword $securePassword `
                   -Enabled $true `
                   -ChangePasswordAtLogon $true `
                   -ErrorAction Stop

        Write-Message "Successfully created user $samAccountName."
    } catch {
        Write-Message "Failed to create user $samAccountName. Error: $_"
        Write-Message "Full Exception: $($_.Exception.ToString())"
    }
}