🛡️ Automated Server Hardening Script

A comprehensive bash script for automating Linux server security hardening. Implements industry best practices for securing production systems against common threats.
📋 Table of Contents

    Features

    Supported Systems

    Quick Start

    Usage

    What It Does

    Security Measures

    Installation

    Configuration

    Testing

    Compliance

    Troubleshooting

    Contributing

    Disclaimer

✨ Features

    🔐 SSH Security Hardening - Key-based authentication, root login disable

    🛡️ Firewall Configuration - UFW/Firewalld setup with secure defaults

    ⚙️ Kernel Hardening - Security-focused sysctl parameters

    📦 Automatic Security Updates - Unattended-upgrades configuration

    👤 User Account Security - Password policies & system account locking

    🚫 Intrusion Prevention - Fail2ban setup for SSH protection

    📊 Compliance Checking - Post-hardening validation checks

    📝 Comprehensive Logging - Detailed audit trail of all changes

    🔄 Safe Operations - Automatic backups before modifications

🖥️ Supported Systems

    Ubuntu 18.04, 20.04, 22.04

    Debian 10, 11

    CentOS 7, 8

    RHEL 7, 8, 9

    Amazon Linux 2

🚀 Quick Start
Prerequisites

    Linux server (fresh install recommended for testing)

    sudo privileges

    Internet access for package downloads

Basic Usage
bash

# Clone the repository
git clone https://github.com/AzerG256/Server-hardening-script
cd server-hardening-script

# Make script executable
chmod +x harden-server.sh

# Run the hardening script
sudo ./harden-server.sh

📖 Usage
Full Hardening
bash

sudo ./harden-server.sh

Dry Run Mode (Preview changes)
bash

sudo ./harden-server.sh --dry-run

Specific Modules Only
bash

# Only SSH and firewall
sudo ./harden-server.sh --modules ssh,firewall

# Only run compliance checks
sudo ./harden-server.sh --check

🔧 What It Does
SSH Hardening

    Disables root SSH login

    Enforces key-based authentication

    Configures secure cryptographic settings

    Sets connection timeouts and attempt limits

Firewall Configuration

    Blocks all incoming traffic by default

    Allows only SSH, HTTP, HTTPS ports

    Configures proper default policies

System Security

    Configures automatic security updates

    Sets secure kernel parameters

    Implements password policies

    Locks down system accounts

Monitoring & Protection

    Installs and configures Fail2ban

    Sets up logging and monitoring

    Implements intrusion detection

🛡️ Security Measures Implemented
Category	Measures
Access Control	SSH key authentication, Root login disabled, Password policies
Network Security	Firewall configuration, SSH port security, Kernel network hardening
System Hardening	Automatic updates, User account security, Service hardening
Monitoring	Fail2ban, System logging, Compliance checks
📥 Installation
Method 1: Direct Download
bash

wget https://raw.githubusercontent.com/AzerG256/server-hardening-script/main/harden-server.sh
chmod +x harden-server.sh
sudo ./harden-server.sh

Method 2: Git Clone (Recommended)
bash

git clone https://github.com/AzerG256/Server-hardening-script
cd server-hardening-script
sudo ./harden-server.sh

⚙️ Configuration
Pre-Configuration Checklist

    Ensure you have SSH key access configured

    Backup important data and configurations

    Note down any custom services needing firewall access

    Verify sudo privileges

Customizing Settings

Edit the configuration files in the configs/ directory:
bash

# Modify SSH settings
nano configs/sshd_config

# Adjust kernel parameters
nano configs/sysctl.conf

# Customize Fail2ban
nano configs/fail2ban_jail.local

Environment Variables

Set these before running for customization:
bash

export HARDENING_SSH_PORT=2222
export HARDENING_ALLOW_USERS="admin deploy"
export HARDENING_ADDITIONAL_PORTS="3000 5432"
sudo ./harden-server.sh

🧪 Testing
Pre-Hardening Checklist
bash

# Test current SSH access
ssh user@your-server

# Check open ports
sudo netstat -tulpn

# Verify current security status
sudo fail2ban-client status

Post-Hardening Verification
bash

# Run compliance checks
sudo ./harden-server.sh --check

# Test SSH key authentication
ssh -i your-key user@your-server

# Verify firewall rules
sudo ufw status verbose

# Check system logs
sudo tail -f /var/log/hardening.log

Testing in Safe Environment

    Create a test VM identical to your production environment

    Run the script and verify all services work

    Test access methods - SSH, web services, applications

    Verify monitoring - logs, Fail2ban, system metrics

📊 Compliance

This script helps implement controls for various security frameworks:
CIS Benchmarks

    2.1.2 Ensure SSH access is limited

    3.1.1 Configure firewall

    5.2.1 Configure SSH settings

    6.2 User account security

NIST Cybersecurity Framework

    PR.AC-1: Identities and credentials are managed

    PR.AC-3: Remote access is managed

    PR.IP-1: Baseline configuration is maintained

    PR.PT-3: Access to systems is controlled

ISO 27001

    A.9.1.2: Access to networks and services

    A.9.2.5: Secure log-on procedures

    A.12.4.1: Event logging

    A.13.1.3: Segregation in networks

🐛 Troubleshooting
Common Issues
SSH Access Lost
bash

# If you get locked out, use console access:
sudo nano /etc/ssh/sshd_config
# Change 'PermitRootLogin no' to 'yes'
# Change 'PasswordAuthentication no' to 'yes'
sudo systemctl restart ssh

Service Not Starting
bash

# Check service status
sudo systemctl status ssh
sudo systemctl status ufw

# View logs
sudo journalctl -u ssh
sudo tail -f /var/log/fail2ban.log

Firewall Blocking Services
bash

# Check current rules
sudo ufw status

# Allow additional ports
sudo ufw allow 3000
sudo ufw allow 5432/tcp

Recovery

Backups are automatically created in:

    SSH: /etc/ssh/sshd_config.backup.*

    Firewall: UFW configuration backups

    Sysctl: /etc/sysctl.conf.backup

🤝 Contributing

We welcome contributions! Please see our Contributing Guide for details.
Development Setup
bash

git clone https://github.com/AzerG256/Server-hardening-script
cd server-hardening-script

# Create test environment
vagrant up  # or use your preferred VM method

# Test changes
./test_hardening.sh

Reporting Issues

Please include:

    Linux distribution and version

    Script version

    Error messages and logs

    Steps to reproduce

⚠️ Disclaimer

Important: This script makes significant changes to your system configuration.

    🚨 ALWAYS TEST in a non-production environment first

    🔐 ENSURE YOU HAVE alternative access methods (console access)

    💾 BACKUP IMPORTANT DATA before proceeding

    📋 REVIEW THE CHANGES the script will make to your system

The authors are not responsible for any downtime, lockouts, or system issues resulting from the use of this script. Use at your own risk.
📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
🙏 Acknowledgments

    Based on CIS Benchmark recommendations

    Inspired by security best practices from major cloud providers

    Community contributions and testing

Maintainer: Azer GRASSI
Support: Create an issue in the GitHub repository
Status: Actively maintained
<div align="center">

⭐ If this project helped you, please give it a star on GitHub!
</div>
