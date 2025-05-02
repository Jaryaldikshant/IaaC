# ⚙️ Terraform Azure Infrastructure with Custom Module

## 📌 Project Overview

This project demonstrates how to build a **custom Terraform module** from scratch to provision infrastructure on **Microsoft Azure**. I used core resources like **Virtual Machines** and **Blob Storage**, and structured the project to support three separate environments:

- **Development**
- **Staging**
- **Production**


The focus of this project was on **learning how to write and organize Terraform code using your own custom modules**, rather than simply consuming existing ones.


---

## 🔧 Technologies Used

- **Terraform**
- **Azure Cloud**
- **Azure Virtual Machines**
- **Azure Blob Storage**
- **Custom Terraform Modules**
- **Azure Resource Group**
- **Multi-environment Structure**

---

## 📁 Project Structure

```bash
.
├──── main.tf
├──── infra-app/
│       ├── vm.tf
│       ├── variables.tf
│       └── blob.tf
├──── provider.tf
├──── terraform.tf
├── README.md
└── terraform.tfvars
