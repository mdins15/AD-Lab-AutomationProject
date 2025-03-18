# AD Lab & Automation Project

This repository documents my **Active Directory (AD) Lab setup** and **PowerShell automation project** for user provisioning.

---

## 📌 **Project Overview**
- **Goal:** Automate user provisioning and deprovisioning in Active Directory using PowerShell.
- **Why?** IT admins spend hours managing user accounts manually. This automation **reduces errors, improves security, and saves time**.
- **Skills Used:**
  ✅ PowerShell scripting  
  ✅ Active Directory automation  
  ✅ CSV-based bulk user creation  

---

## 🚀 **Lab Setup Overview**
This lab was built to test **Active Directory automation** and includes:

- **Domain Controller (DC1)** – Windows Server 2022 (Active Directory, DNS)
- **Client VM** – Windows 11 (Domain-Joined)
- **Networking**:
  - **Internal Network** (for AD communication)
  - **Bridged Mode** (for internet access)

### **🔹 Steps to Set Up the Lab**
1️⃣ **Install Windows Server 2022** and configure a **static IP**.  
2️⃣ **Promote DC1 to a Domain Controller** (`YourDomain.local`).  
3️⃣ **Join a Windows Client VM to the Domain**.  
4️⃣ **Set up a shared folder on DC1** for testing.  
5️⃣ **Verify user authentication and access control**.

---

## 🛠️ **Automation Scripts**
### ✅ **PowerShell Scripts for User Provisioning**
| Script Name            | Purpose |
|------------------------|---------|
| `setup-ad.ps1`        | Promotes server to Domain Controller |
| `create-users.ps1`    | Bulk-create users in AD from a CSV file |
| `configure-network.ps1` | Configure IP & DNS settings for AD |

---

## 📌 **Next Steps**
- **Automate Group Policy (GPO) deployment.**
- **Implement role-based security permissions.**
- **Set up home drives for users.**
