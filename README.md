# Network-Research
Automated Bash script for network scanning and SSH brute-force auditing using Hydra.
# Network Research Project - SSH Brute-Forcer 🚀

An automated Bash script designed for network security research, scanning, and SSH credential auditing. This tool automates the workflow of identifying active hosts and testing for weak credentials using **Hydra**.

## 🛠 Features
* **Network Discovery:** Scan specific IPs or entire subnets (CIDR).
* **Automated Auditing:** Streamlined integration with the Hydra brute-force engine.
* **Flexible Wordlists:** Use built-in default lists or upload your own custom username/password files.
* **Result Logging:** Automatically saves successful logins and post-exploitation data to `successful_logins.txt`.

## 📋 Prerequisites
Before running the script, ensure you have the following installed:
* **Linux Environment** (Kali Linux is highly recommended)
* **Hydra:** `sudo apt install hydra`
* **Nmap:** (If used by the script for scanning)

## 🚀 How to Use
1. **Clone or download** the script to your machine.
2. **Give execution permissions:**
   ```bash
   chmod +x your_script_name.sh
   ```
3. **Run the tool:**
   ```bash
   ./your_script_name.sh
   ```
4. Follow the on-screen prompts to enter the IP range and select your wordlists.

## ⚠️ Disclaimer
This project is for **educational and ethical security testing purposes only**. Unauthorized access to systems is illegal. The author is not responsible for any misuse of this tool.
