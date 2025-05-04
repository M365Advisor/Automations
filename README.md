# M365Advisor PowerShell Automation Toolkit

Welcome to the **M365Advisor** GitHub repository — a growing collection of practical PowerShell scripts created to save time, reduce effort, and help Microsoft 365 Admins and IT pros feel like automation heroes again. 💻🧙‍♂️

This project was born out of my reddit post and real-world frustration: constant tickets, repetitive license tasks, endless clicking in the admin center. The goal? **Make M365 and IT Admins cool again.**

---

## 📦 What's Inside

This repo currently includes:

### 🔄 1. Bulk License Assignment
- Script: `Onboarding.ps1`
- Purpose: Automatically creates users from an HR-provided CSV and assigns the correct M365 licenses.
- Ideal for: New joiner onboarding, internship batches, or vendor rollouts.
- [README](Bulk%20Assignment%20README.md)

### 💤 2. Inactive Users License Report
- Script: `InactiveUsers.ps1`
- Purpose: Identifies users inactive in Teams and Exchange for 90+ days and still holding licenses.
- Output: Exports a CSV of potentially reclaimable licenses.
- [README](Inactive%20Users%20Readme.md)

### 💤 3. Sharepoint and OneDrive permissions audit - Coming shortly in 1 to 2 days. 
More scripts and automations coming soon. Have an idea? Keep reading 👇

---

## 🧭 How to Use This Repo

1. **Download** this repo:
download as ZIP → extract.

2. **Navigate to the folder in PowerShell**:
```powershell
cd "C:\Path\To\M365Advisor"
```

3. **Run PowerShell as Administrator**
> Some scripts need elevated permissions for module installation and connection to Exchange/Teams

4. **Follow README inside each script folder** for setup, modules, and example CSVs

---

## 📚 Index of Scripts

| Script Name           | Description                                       | CSV Required | Modules Used                        |
|----------------------|---------------------------------------------------|--------------|--------------------------------------|
| `Onboarding.ps1`     | Bulk create users and assign licenses             | ✅           | MSOnline                             |
| `InactiveUsers.ps1`  | Find inactive users with licenses (90+ days)     | ❌           | MSOnline, ExchangeOnline, Teams      |

---

## 💡 Why This Exists

I started this due to a viral Reddit post request. Like most M365 admins, I used to hate my job—constant tickets, dumb requests, and bosses who think clicking buttons all day is “IT strategy.” So, I automated most of it and decided to share it.

If this helps even one person avoid burnout or reclaim a few licenses, mission accomplished.

---

## 🙋‍♀️ Contributing / Collaborating

I’d love to grow this into a community-driven toolkit. If you're an M365 Admin, IT pro, or scripting enthusiast:
- **Raise issues** with bugs or suggestions
- **Submit a PR** with your own script or enhancement
- **Drop an idea** and I might build it for you 😄

Let’s make this a go-to place for practical M365 automation.

---

## 📢 About Me

I enjoy saving Microsoft 365 license costs using **technical and scientific methods**, not just spreadsheets. I'm currently building a **simple, cool optimization tool** in beta that:
- Suggests downgrades
- Removes unused buffer licenses
- Provides actionable savings insights

👉 Want to join the beta or waitlist? Email me at **info@m365advisor.us** or visit [m365advisor.us](https://www.m365advisor.us)

Suggestions and feedback are always welcome. Let’s make IT admin easier, smarter, and maybe even a little fun.

---

**© 2025 m365advisor.us | All Rights Reserved**

**Happy scripting!**

