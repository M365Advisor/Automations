<#
Bulk User and License Provisioning Script

© 2025 m365advisor.us | All Rights Reserved
If you find this script useful and share it, please provide me coffee if we ever meet.
#>

# Check if NuGet is available
if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Write-Host "Installing NuGet provider..." -ForegroundColor Cyan
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
}

# Set PSGallery as trusted
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

# Install MSOnline if not present
if (-not (Get-Module -ListAvailable -Name MSOnline)) {
    Write-Host 'MSOnline module not found. Installing now...' -ForegroundColor Cyan
    Install-Module -Name MSOnline -Force -Scope CurrentUser
}


# Connect to Microsoft 365
Try {
    Write-Host "Connecting to Microsoft 365..." -ForegroundColor Cyan
    Connect-MsolService -ErrorAction Stop
}
Catch {
    Write-Error "Failed to connect to Microsoft 365. Please verify your credentials and permissions. $_"
    Exit
}

# Ensure running as Administrator
If (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")) {
    Write-Error "Please run this script as Administrator."
    Exit
}

# Prompt user for CSV file path
Do {
    $csvFilePath = Read-Host "Enter the full path to the CSV file provided by HR"
    if (!(Test-Path $csvFilePath)) {
        Write-Warning "File not found. Please enter a valid path."
    }
} While (!(Test-Path $csvFilePath))

# Import Users
Try {
    $users = Import-Csv -Path $csvFilePath -ErrorAction Stop
}
Catch {
    Write-Error "Error importing CSV file. Ensure file format is correct. $_"
    Exit
}

# Validate Required CSV Columns
$requiredColumns = @("UserPrincipalName", "FirstName", "LastName", "LicenseSku", "Country", "UsageLocation")
foreach ($column in $requiredColumns) {
    if (-not $users[0].PSObject.Properties.Name.Contains($column)) {
        Write-Error "The CSV file is missing the required column: $column"
        Exit
    }
}

Foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    $firstName = $user.FirstName
    $lastName = $user.LastName
    $licenseSku = $user.LicenseSku
    $country = $user.Country
    $usageLocation = $user.UsageLocation

    Write-Host "Processing user: $upn" -ForegroundColor Yellow

    Try {
        # Check if user already exists
        $existingUser = Get-MsolUser -UserPrincipalName $upn -ErrorAction SilentlyContinue

        If (-not $existingUser) {
            # Create new user if not existing
            $password = [System.Web.Security.Membership]::GeneratePassword(12, 2)
            New-MsolUser -UserPrincipalName $upn -FirstName $firstName -LastName $lastName -Country $country -UsageLocation $usageLocation -Password $password -ForceChangePassword $true -ErrorAction Stop
            Write-Host "New user created: $upn" -ForegroundColor Green
        }

        # Assign license
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $licenseSku -ErrorAction Stop
        Write-Host "License ($licenseSku) assigned successfully to $upn" -ForegroundColor Green
    }
    Catch {
        Write-Warning "Error processing user $upn. Ensure license SKU, country, and other details are correct. $_"
        Continue
    }
}

Write-Host "`nBulk provisioning script execution completed successfully." -ForegroundColor Cyan
Write-Host "For suggestions or feature requests, please email harshaa@m365advisor.us" -ForegroundColor Magenta

# Artwork
Write-Host "`n"
Write-Host "*********************************************" -ForegroundColor Blue
Write-Host "*                                           *" -ForegroundColor Blue
Write-Host "*        M365 Bulk License Provisioner      *" -ForegroundColor Green
Write-Host "*            2025 m365advisor.us           *" -ForegroundColor Green
Write-Host "*                                           *" -ForegroundColor Blue
Write-Host "*********************************************" -ForegroundColor Blue
