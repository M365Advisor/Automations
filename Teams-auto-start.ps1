
# Teams Auto-Start Setup via Intune - System-Wide Script with Error Handling
$logPath = "C:\ProgramData\TeamsAutoStart\setup.log"

function Log-Message {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "$timestamp - $message"
    Add-Content -Path $logPath -Value $entry
}

# Ensure log directory exists
$logDir = Split-Path $logPath
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

try {
    $teamsInstallerPath = "C:\Program Files (x86)\Teams Installer\Teams.exe"
    $runKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
    $valueName = "Teams"

    if (Test-Path $teamsInstallerPath) {
        Log-Message "Teams Installer found at: $teamsInstallerPath"

        # Create registry key and set auto-start value
        try {
            if (-not (Test-Path $runKey)) {
                New-Item -Path $runKey -Force | Out-Null
                Log-Message "Created missing Run registry key"
            }

            $valueData = "`"$teamsInstallerPath`" --processStart `"`"Teams.exe`"`" --system-initiated"
            Set-ItemProperty -Path $runKey -Name $valueName -Value $valueData -Force
            Log-Message "Teams auto-start registry value set successfully"
        }
        catch {
            Log-Message "Failed to set registry value: $_"
        }
    }
    else {
        Log-Message "Teams Installer not found at expected path: $teamsInstallerPath"
    }
}
catch {
    Log-Message "Unexpected error occurred: $_"
}
