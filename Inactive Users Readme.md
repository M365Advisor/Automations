# 2) M365 Inactive Users License Report Script

A PowerShell script to identify Microsoft 365 users who have been inactive (no Exchange or Teams activity) for more than 90 days and still hold a license. Ideal for IT admins and license managers looking to optimize license usage.

---

## 🚀 Features

- Finds inactive users based on **Exchange Online** and **Microsoft Teams** activity
- Filters users who **have active licenses assigned**
- Automatically installs required modules: `MSOnline`, `ExchangeOnlineManagement`, `MicrosoftTeams`
- Avoids popups by trusting PSGallery
- Exports report to `inactive_users.csv` in the script folder

---

## 📦 Prerequisites

- Windows PowerShell 5.1+
- Run PowerShell **as Administrator**
- Microsoft 365 permissions:
  - Global Admin or User Admin
  - Exchange Admin
  - Teams Admin

The script will:
- Set Execution Policy to `Bypass` (for session only)
- Trust PowerShell Gallery
- Auto-install missing modules

---

## 🛠️ How to Use

1. **Run PowerShell as Administrator**
2. Navigate to the folder containing the script:
   ```powershell
   cd "C:\Path\To\Script"
   ```
3. Run the script:
   ```powershell
   .\InactiveUsersReport.ps1
   ```
4. Wait for the connections and scan to complete.

---

## 📂 Output File

- A CSV file named `inactive_users.csv` is created in the same folder
- Columns included:
  - `UserPrincipalName`
  - `ExchangeLastActivity`
  - `TeamsLastActivity`
  - `LastActivity`

---

## 📘 Execution Policy Troubleshooting

If the script does not run due to execution policy restrictions, run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Or temporarily for the session only:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

More info: [about_Execution_Policies](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies)

---

## 📉 License SKU Optimization (Coming Soon!)

This script is part of a broader goal to help optimize Microsoft 365 licensing.
We're building a beta tool that:
- Recommends **license downgrades** based on actual usage
- Identifies **inactive or underutilized licenses**
- Suggests **buffer license** reductions
- Makes **automated recommendations** for license reallocation

Want to test it early? **Join the beta** by emailing us or visiting [m365advisor.us](https://www.m365advisor.us)

---

## 🧙‍♂️ Credits & Contact

© 2025 [m365advisor.us](https://www.m365advisor.us) | All Rights Reserved  
If you find this script useful and we cross paths someday, feel free to buy me a coffee ☕

I love optimization and am building a tool in beta to automate license management, usage-based downgrades, and buffer cleanup — all in one cool dashboard. 😎  
If that sounds helpful, **join the waitlist** at [m365advisor.us](https://www.m365advisor.us) or drop me a line.

📧 Suggestions or feature requests: **harshaa@m365advisor.us**

---

**Make licensing boring again — in a good way.**

