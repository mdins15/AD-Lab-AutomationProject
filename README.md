### **🔹 Updated README with Your Actual Script Names**  
This update ensures that your README correctly reflects your **actual script names** while maintaining clarity and structure.

---

# **🖥️ AD Lab & Automation Project**
This repository documents my **Active Directory (AD) Lab setup** and **PowerShell automation project** for user provisioning.

---

## **📌 Project Overview**
### **🔹 Goal:**  
Automate **user provisioning and deprovisioning** in Active Directory using **PowerShell**.

### **🔹 Why?**
🔹 IT admins **spend hours** managing user accounts manually.  
🔹 Automation **reduces errors, improves security, and saves time**.  

### **🔹 Skills Used:**
✅ **PowerShell scripting**  
✅ **Active Directory automation**  
✅ **CSV-based bulk user creation**  

---

## **🚀 Lab Setup Overview**
This lab was built to **test and deploy Active Directory automation** and includes:

### **🖥️ Virtual Machines**
| **System**  | **OS** | **Roles** |
|------------|-------|-----------|
| **DC1** | Windows Server 2022 | **Domain Controller**, DNS |
| **Client VM** | Windows 11 | **Domain-Joined Workstation** |

### **🌐 Networking Configuration**
| **Adapter** | **Purpose** |
|------------|------------|
| **Internal Network** | AD communication (DC ↔ Clients) |
| **Bridged Mode** | Internet access |

---

## **🔹 Steps to Set Up the Lab**
1️⃣ **Install Windows Server 2022** and configure a **static IP**.  
2️⃣ **Promote DC1** to a **Domain Controller** (`YourDomain.local`).  
3️⃣ **Join a Windows Client VM** to the **Active Directory domain**.  
4️⃣ **Set up a shared folder** on DC1 for testing.  
5️⃣ **Verify user authentication and access control.**  

---

## **🛠️ Automation Scripts**
✅ **PowerShell Scripts for User Provisioning & Configuration**

| **Script Name**                          | **Purpose** |
|-------------------------------------------|-----------------------------------------------------------|
| `Create-ADUsersFromCSV.ps1`               | Bulk-creates users in AD from a CSV file. |
| `Create-OU-and-Users-With-ErrorLogging.ps1` | Creates OUs and users with error handling and logging. |
| `Create-OU-and-Users.ps1`                 | Creates Organizational Units (OUs) and users in AD. |

---

## **📌 Next Steps**
🚀 **Expand automation capabilities with:**
- ✅ Automating **Group Policy (GPO) deployment**.
- ✅ Implementing **role-based security permissions**.
- ✅ Setting up **home drives for users**.
- ✅ Integrating **automated user deprovisioning**.
