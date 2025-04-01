<#
Inactive Users License Report Script

© 2025 m365advisor.us | All Rights Reserved
If you find this script useful, coffee is always appreciated if we ever meet.
#>

# Ensure running as Administrator
If (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")) {
    Write-Error "Please run this script as Administrator."
    Exit
}

# Set Execution Policy for this session only
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Check and install required modules without popups
Function Ensure-Module($module) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Write-Host "$module module not found. Installing now..." -ForegroundColor Cyan
        Install-Module $module -Force -Scope CurrentUser -AllowClobber -Repository PSGallery
    }
}

# Trust PSGallery to avoid untrusted repository popups
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

# Ensure required modules
Ensure-Module "MSOnline"
Ensure-Module "ExchangeOnlineManagement"
Ensure-Module "MicrosoftTeams"

# Connect to MSOnline
Try {
    Write-Host "Connecting to MSOnline..." -ForegroundColor Cyan
    Connect-MsolService -ErrorAction Stop
}
Catch {
    Write-Error "Failed to connect to MSOnline. Check credentials and permissions. $_"
    Exit
}

# Connect to Exchange Online
Try {
    Write-Host "Connecting to Exchange Online..." -ForegroundColor Cyan
    Connect-ExchangeOnline -ErrorAction Stop
}
Catch {
    Write-Error "Failed to connect to Exchange Online. Check credentials and permissions. $_"
    Exit
}

# Connect to Teams
Try {
    Write-Host "Connecting to Microsoft Teams..." -ForegroundColor Cyan
    Connect-MicrosoftTeams -ErrorAction Stop
}
Catch {
    Write-Error "Failed to connect to Teams. Check credentials and permissions. $_"
    Exit
}

# Get licensed users
$licensedUsers = Get-MsolUser -All | Where-Object { $_.isLicensed -eq $true }
Write-Host "Total licensed users found: $($licensedUsers.Count)" -ForegroundColor Green

$inactiveUsers = @()

# Threshold date
$inactiveThreshold = (Get-Date).AddDays(-90)

# Check inactivity for each user
foreach ($user in $licensedUsers) {
    $upn = $user.UserPrincipalName

    # Exchange activity
    $mailboxActivity = Get-EXOMailboxStatistics -Identity $upn -ErrorAction SilentlyContinue | Select LastLogonTime
    $exchangeLastActivity = $mailboxActivity.LastLogonTime

    # Teams activity
    $teamsActivity = Get-CsOnlineUser -Identity $upn -ErrorAction SilentlyContinue | Select LastActivityTimestamp
    $teamsLastActivity = $teamsActivity.LastActivityTimestamp

    # Determine most recent activity
    $lastActivity = ($exchangeLastActivity, $teamsLastActivity | Where-Object {$_} | Sort-Object -Descending)[0]

    if (-not $lastActivity -or $lastActivity -lt $inactiveThreshold) {
        $inactiveUsers += [PSCustomObject]@{
            UserPrincipalName = $upn
            ExchangeLastActivity = $exchangeLastActivity
            TeamsLastActivity = $teamsLastActivity
            LastActivity = $lastActivity
        }
        Write-Host "Inactive: $upn" -ForegroundColor Yellow
    }
}

# Export results
$outputFile = ".\inactive_users.csv"
$inactiveUsers | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Inactive users exported successfully to $outputFile" -ForegroundColor Cyan