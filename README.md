# M365 Bulk User & License Provisioning Script

A PowerShell script that automates the creation of Microsoft 365 users and assigns them licenses in bulk using a CSV file. Built to save IT admins time and avoid the repetitive clicks of the M365 Admin Center.

---

## 🚀 Features

- Bulk creation of M365 user accounts from a CSV
- Automatic license assignment (e.g., Office 365 E3, Business Standard)
- Automatic mailbox provisioning if Exchange Online is included
- Graceful handling of already existing users
- Validates required fields from the CSV
- Installs required modules and providers automatically (NuGet, MSOnline)
- Provides clear progress messages and error handling

---

## 📦 Prerequisites

- Windows with PowerShell 5.1 or later
- Admin privileges (Run PowerShell as Administrator)
- Microsoft 365 Global Admin or User Management Admin role

The script auto-installs:
- NuGet provider (if missing)
- MSOnline PowerShell module
- Sets PSGallery as a trusted repository

---

## 📂 CSV Format Example

Save your user data in a file named `HRUsers.csv` like this:

```csv
UserPrincipalName,FirstName,LastName,LicenseSku,Country,UsageLocation
john.doe@contoso.com,John,Doe,contoso:ENTERPRISEPACK,US,US
jane.smith@contoso.com,Jane,Smith,contoso:O365_BUSINESS_PREMIUM,US,US
```

To find your license SKUs:
```powershell
Connect-MsolService
Get-MsolAccountSku
```
Example result:
```
contoso:ENTERPRISEPACK
contoso:O365_BUSINESS_PREMIUM
```
Use the exact `LicenseSku` in your CSV.

---

## 📥 How to Use

1. Open PowerShell **as Administrator**
2. Navigate to the folder where the script is saved:
   ```powershell
   cd "C:\Path\To\Script"
   ```
3. Run the script:
   ```powershell
   .\Onboarding.ps1
   ```
4. Enter the full path to your CSV file when prompted:
   ```
   C:\Users\YourName\Desktop\HRUsers.csv
   ```

---

## 🛠️ What It Does

- Connects to M365 using `Connect-MsolService`
- Reads and validates the CSV
- Creates users (if not already present)
- Assigns licenses
- Mailbox is automatically created if license includes Exchange Online

---

## 🔐 Execution Policy Note
If you get an error like `running scripts is disabled`, run:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Or for one-time use:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

More info: [about_Execution_Policies](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies)

---

## 📘 Supported License SKUs (Examples)

| License Name                     | LicenseSku Format                 |
|----------------------------------|-----------------------------------|
| Office 365 E3                   | contoso:ENTERPRISEPACK            |
| M365 Business Standard          | contoso:O365_BUSINESS_PREMIUM     |
| Office 365 E1                   | contoso:STANDARDPACK              |
| Microsoft 365 E3                | contoso:SPE_E3                    |
| Microsoft 365 E5                | contoso:SPE_E5                    |

Replace `contoso` with your actual tenant prefix.

---

## 🧙‍♂️ Credits & Contact

© 2025 [m365advisor.us](https://www.m365advisor.us) | All Rights Reserved  
If you find this script useful and we cross paths someday, feel free to buy me a coffee ☕  

I hope to build multiple automations — license management, optimization, and permissions — into one simple, cool tool to make M365 Admins and IT Admins life cool again. 😎  
If you find this vision interesting, do support by **joining the waitlist** at [m365advisor.us](https://www.m365advisor.us).

📧 Suggestions or feature requests: **harshaa@m365advisor.us**

