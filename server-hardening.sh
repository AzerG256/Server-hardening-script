#!/usr/bin/env bash

# Server Hardening Script - Learning Project
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Logging function
log() {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $1"
}

echo "Starting server hardening process..."
log "Script started"
harden_ssh() {
    log "Starting SSH hardening..."
    
    # Backup original SSH config
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup.$(date +%Y%m%d)
    
    # Disable root login
    sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    
    # Disable password authentication (key-based only)
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    
    # Restart SSH service
    sudo systemctl restart ssh
    
    log "SSH hardening completed"
}
harden_ssh
setup_firewall() {
    log "Configuring firewall..."
    
    # Install UFW if not present
    if ! command -v ufw >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y ufw
    fi
    
    # Reset and configure UFW
    echo "y" | sudo ufw reset
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow https
    echo "y" | sudo ufw enable
    
    log "Firewall configured and enabled"
}
setup_firewall
harden_packages() {
    log "Configuring system updates..."
    
    # Update system
    sudo apt update && sudo apt upgrade -y
    
    # Install security tools
    sudo apt install -y fail2ban unattended-upgrades
    
    # Configure automatic security updates
    sudo dpkg-reconfigure -plow unattended-upgrades
    
    log "System updates configured"
}
harden_packages
harden_kernel() {
    log "Applying kernel security parameters..."
    
    # Backup sysctl.conf
    sudo cp /etc/sysctl.conf /etc/sysctl.conf.backup
    
    # Add security settings
    echo "# Security Hardening - Added by script" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv4.ip_forward=0" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv4.conf.all.send_redirects=0" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv4.conf.all.accept_redirects=0" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv4.tcp_syncookies=1" | sudo tee -a /etc/sysctl.conf
    
    # Reload settings
    sudo sysctl -p
    
    log "Kernel hardening applied"
}
harden_kernel
harden_users() {
    log "Securing user accounts..."
    
    # Set password policy
    sudo sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
    
    # Lock system accounts
    for user in sync games man lp mail news uucp; do
        if id "$user" &>/dev/null; then
            sudo usermod -L -s /sbin/nologin "$user"
        fi
    done
}
harden_users
setup_fail2ban() {
    log "Configuring Fail2ban..."
    
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
}
setup_fail2ban
run_checks() {
    log "Running security checks..."
    
    # Check if root login is disabled
    if grep -q "PermitRootLogin yes" /etc/ssh/sshd_config; then
        echo "❌ FAIL: Root login enabled"
    else
        echo "✅ PASS: Root login disabled"
    fi
    
    # Check firewall
    if sudo ufw status | grep -q "Status: active"; then
        echo "✅ PASS: Firewall active"
    else
        echo "❌ FAIL: Firewall not active"
    fi
}
run_checks
