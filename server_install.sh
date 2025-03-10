#!/bin/bash

# 🚀 OS Panel Installer with Security, Firewall, and Backups
echo "========================================"
echo "🛠️  OS Panel Installer for Ubuntu 22.04 "
echo "========================================"
echo "Version 1"
echo "1️⃣  Coolify (Docker-based PaaS)"
echo "2️⃣  Dokku (Heroku-like deployment)"
echo "3️⃣  Portainer (Docker management UI)"
echo "4️⃣  Rancher (Enterprise Kubernetes)"
echo "5️⃣  K3s (Lightweight Kubernetes)"
echo "6️⃣  HestiaCP (Web hosting panel)"
echo "7️⃣  CyberPanel (LiteSpeed hosting panel)"
echo "8️⃣  aaPanel (Easy hosting panel)"
echo "9️⃣  ISPConfig (Advanced web hosting panel)"
echo "🔟  Webmin (Linux system control panel)"
echo "1️⃣1️⃣  CapRover (Simple Docker hosting)"
echo "1️⃣2️⃣  CloudPanel (Modern hosting panel)"
echo "1️⃣3️⃣  Virtualmin (Webmin-based hosting panel)"
echo "1️⃣4️⃣  Froxlor (Lightweight hosting panel)"
echo "1️⃣5️⃣  Ajenti (Minimalist web control panel)"
echo "1️⃣6️⃣  EasyPanel (Simple Docker web panel)"
echo "1️⃣7️⃣  YunoHost (Self-hosted app manager)"
echo "1️⃣8️⃣  One-Click Deploy (LinuxServer.io)"
echo "0️⃣  Exit"
echo ""
read -p "👉 Select an option (1-18): " choice

confirm_installation() {
    read -p "Are you sure you want to install $1? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        echo "❌ Installation of $1 cancelled."
        exit 1
    fi
}

run_command() {
    echo "🚀 Running: $1"
    eval "$1"
    if [[ $? -ne 0 ]]; then
        echo "❌ Error occurred during: $1"
        exit 1
    fi
}

# 🔥 Dependency Setup
setup_dependencies() {
    echo "🔧 Installing necessary dependencies..."
    run_command "apt update"
    run_command "apt install -y curl wget apt-transport-https gnupg lsb-release software-properties-common docker.io"
    echo "✅ Dependencies installed!"
}

# 🔥 Security Setup
setup_firewall() {
    echo "🛡️  Configuring UFW firewall..."
    run_command "ufw default deny incoming"
    run_command "ufw default allow outgoing"
    run_command "ufw allow 22/tcp"  # SSH
    run_command "ufw allow 80/tcp"  # HTTP
    run_command "ufw allow 443/tcp" # HTTPS
    run_command "ufw --force enable"
    echo "✅ Firewall configured!"
}

setup_fail2ban() {
    echo "🛡️  Installing and configuring Fail2Ban..."
    run_command "apt install -y fail2ban"
    run_command "systemctl enable fail2ban --now"
    echo "✅ Fail2Ban installed and active!"
}

setup_ssh_security() {
    echo "🛡️  Hardening SSH security..."
    run_command "sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config"
    run_command "sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config"
    run_command "systemctl restart sshd"
    echo "✅ SSH hardened! (Root login disabled)"
}

setup_auto_backup() {
    echo "💾 Setting up automatic backups..."
    cat <<EOF > /etc/cron.daily/server-backup
#!/bin/bash
tar -czf /root/server-backup-\$(date +\%F).tar.gz /etc /var/www /root
EOF
    run_command "chmod +x /etc/cron.daily/server-backup"
    echo "✅ Automatic backups enabled!"
}

# 🔥 OS Panel Installers
install_coolify() { confirm_installation "Coolify"; run_command "curl -fsSL https://get.coollabs.io/coolify/install.sh | bash"; }
install_dokku() { confirm_installation "Dokku"; run_command "wget https://dokku.com/install.sh && sudo bash install.sh"; }
install_portainer() { confirm_installation "Portainer"; run_command "docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce"; }
install_rancher() { confirm_installation "Rancher"; run_command "docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher"; }
install_k3s() { confirm_installation "K3s"; run_command "curl -sfL https://get.k3s.io | sh -"; }
install_hestiacp() { confirm_installation "HestiaCP"; run_command "wget https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh && bash hst-install.sh"; }
install_cyberpanel() { confirm_installation "CyberPanel"; run_command "sh <(curl -fsSL https://cyberpanel.net/install.sh)"; }
install_aapanel() { confirm_installation "aaPanel"; run_command "curl -fsSL http://www.aapanel.com/script/install-ubuntu_6.0_en.sh | bash"; }
install_ispconfig() { confirm_installation "ISPConfig"; run_command "wget -O - https://get.ispconfig.org | sh"; }
install_webmin() { confirm_installation "Webmin"; run_command "wget -qO - http://www.webmin.com/jcameron-key.asc | sudo apt-key add -"; run_command "sudo add-apt-repository 'deb http://download.webmin.com/download/repository sarge contrib'"; run_command "sudo apt update"; run_command "sudo apt install webmin -y"; }
install_caprover() { confirm_installation "CapRover"; run_command "curl -fsSL https://deb.caprover.com/install.sh | bash"; }
install_cloudpanel() { confirm_installation "CloudPanel"; run_command "curl -sSL https://installer.cloudpanel.io/ce/v2/install.sh | bash"; }
install_virtualmin() { confirm_installation "Virtualmin"; run_command "wget https://software.virtualmin.com/gpl/scripts/install.sh && sudo bash install.sh"; }
install_froxlor() { confirm_installation "Froxlor"; run_command "apt update && apt install -y froxlor"; }
install_ajenti() { confirm_installation "Ajenti"; run_command "wget -O- https://raw.githubusercontent.com/ajenti/ajenti/master/scripts/install.sh | sudo bash"; }
install_easypanel() { confirm_installation "EasyPanel"; run_command "curl -fsSL https://get.easypanel.io | bash"; }
install_yunohost() { confirm_installation "YunoHost"; run_command "curl https://install.yunohost.org | bash"; }

# 🔥 One-Click Deploy Installers
one_click_deploy() {
    echo "========================================"
    echo "🛠️  One-Click Deploy (LinuxServer.io)"
    echo "========================================"
    echo ""
    echo "1️⃣  Plex"
    echo "2️⃣  Nextcloud"
    echo "3️⃣  Jellyfin"
    echo "4️⃣  Sonarr"
    echo "5️⃣  Radarr"
    echo "6️⃣  Lidarr"
    echo "7️⃣  Tautulli"
    echo "8️⃣  Exit"
    echo ""
    read -p "👉 Select an option (1-8): " deploy_choice

    case "$deploy_choice" in
        1) deploy_image "linuxserver/plex" ;;
        2) deploy_image "linuxserver/nextcloud" ;;
        3) deploy_image "linuxserver/jellyfin" ;;
        4) deploy_image "linuxserver/sonarr" ;;
        5) deploy_image "linuxserver/radarr" ;;
        6) deploy_image "linuxserver/lidarr" ;;
        7) deploy_image "linuxserver/tautulli" ;;
        8) echo "❌ Exiting..."; exit 0 ;;
        *) echo "❌ Invalid option. Please run the script again." ;;
    esac
}

deploy_image() {
    local image=$1
    read -p "Enter the container name: " container_name
    read -p "Enter the host port: " host_port
    read -p "Enter the container port: " container_port
    read -p "Enter the volume mapping (host_path:container_path): " volume_mapping

    run_command "docker run -d --name $container_name -p $host_port:$container_port -v $volume_mapping $image"
    echo "✅ $image deployed successfully!"
}

case "$choice" in
    1) install_coolify ;;
    2) install_dokku ;;
    3) install_portainer ;;
    4) install_rancher ;;
    5) install_k3s ;;
    6) install_hestiacp ;;
    7) install_cyberpanel ;;
    8) install_aapanel ;;
    9) install_ispconfig ;;
    10) install_webmin ;;
    11) install_caprover ;;
    12) install_cloudpanel ;;
    13) install_virtualmin ;;
    14) install_froxlor ;;
    15) install_ajenti ;;
    16) install_easypanel ;;
    17) install_yunohost ;;
    18) one_click_deploy ;;
    0) echo "❌ Exiting..."; exit 0 ;;
    *) echo "❌ Invalid option. Please run the script again." ;;
esac

# 🔥 Apply Security Enhancements After Installation
setup_firewall
setup_fail2ban
setup_ssh_security
setup_auto_backup

echo "========================================"
echo "✅ Installation & Security Setup Complete!"
echo "🛡️  Firewall & Fail2Ban configured"
echo "🔐 SSH Hardened (Root login disabled)"
echo "💾 Automatic backups enabled"
echo "========================================"
