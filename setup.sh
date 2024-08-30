#!/bin/bash

# Log files
SUCCESS_LOG="install_success.log"
FAILURE_LOG="install_failure.log"

# Clear previous logs
echo "" > $SUCCESS_LOG
echo "" > $FAILURE_LOG

# Function to check and install software
install_software() {
    local name=$1
    local check_command=$2
    local install_command=$3

    echo "Checking $name..."
    if ! $check_command &> /dev/null; then
        echo "$name is not installed. Installing..."
        if eval $install_command &> /dev/null; then
            echo "$name installation successful."
            echo "$name" >> $SUCCESS_LOG
        else
            echo "$name installation failed."
            echo "$name" >> $FAILURE_LOG
        fi
    else
        echo "$name is already installed."
    fi
}

# Check and install each software
# General Purpose Coding
install_software "VSCode" "command -v code" "sudo apt update && sudo apt install -y code || sudo snap install code --classic"
install_software "Jupyter Notebook" "command -v jupyter" "pip install jupyter"
# Video Editing and Recording
install_software "OBS" "command -v obs" "sudo apt update && sudo apt install -y obs-studio"
install_software "Kdenlive" "command -v kdenlive" "sudo apt update && sudo apt install -y kdenlive"
# Gaming
install_software "Steam" "command -v steam" "sudo apt update && sudo apt install -y steam"
# Browsers
install_software "Opera" "command -v opera" "sudo apt update && sudo apt install -y opera-stable || sudo snap install opera"
install_software "Brave" "command -v brave-browser" "sudo apt install -y curl && sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main' | sudo tee /etc/apt/sources.list.d/brave-browser-release.list && sudo apt update && sudo apt install -y brave-browser"
# Social
install_software "Discord" "command -v discord" "sudo apt update && sudo apt install -y discord || sudo snap install discord"
# Python
install_software "Python" "command -v python3" "sudo apt update && sudo apt install -y python3 python3-pip"
install_software "Conda" "command -v conda" "wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && bash ~/miniconda.sh -b -p $HOME/miniconda && export PATH=\"$HOME/miniconda/bin:$PATH\""
# Web Stack
install_software "Node.js" "command -v node" "sudo apt update && sudo apt install -y nodejs npm"
install_software "NVM" "command -v nvm" "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && source ~/.bashrc"
install_software "Bun.js" "command -v bun" "curl -fsSL https://bun.sh/install | bash"
install_software "Deno" "command -v deno" "curl -fsSL https://deno.land/x/install/install.sh | sh"
# Databases and Docker
install_software "SQL" "command -v mysql" "sudo apt update && sudo apt install -y mysql-server"
install_software "Postgres" "command -v psql" "sudo apt update && sudo apt install -y postgresql postgresql-contrib"
install_software "MongoDB" "command -v mongod" "wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add - && echo 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list && sudo apt update && sudo apt install -y mongodb-org"
install_software "Docker" "command -v docker" "sudo apt update && sudo apt install -y docker.io && sudo systemctl start docker && sudo systemctl enable docker"
install_software "Docker Compose" "command -v docker-compose" "sudo apt update && sudo apt install -y docker-compose"
# Low Level Programming
install_software "Rust" "command -v rustc" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
install_software "Go" "command -v go" "sudo apt update && sudo apt install -y golang-go"
install_software "C#" "command -v dotnet" "wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && sudo apt update && sudo apt install -y dotnet-sdk-6.0"
# AI Tools
install_software "Ollama" "command -v ollama" "curl -fsSL https://ollama.com/install.sh | bash"
install_software "Autogen" "command -v autogen" "sudo apt update && sudo apt install -y autogen"
install_software "GPT4All" "command -v gpt4all" "pip install gpt4all"
install_software "Stable Diffusion" "command -v sd" "pip install stable-diffusion"


# Security Tools
install_software "UFW" "command -v ufw" "sudo apt update && sudo apt install -y ufw && sudo ufw enable && sudo ufw default deny"
install_software "ClamAV" "command -v clamscan" "sudo apt update && sudo apt install -y clamav clamav-daemon && sudo freshclam"
install_software "rkhunter" "command -v rkhunter" "sudo apt update && sudo apt install -y rkhunter && sudo rkhunter --update"
install_software "KeePassXC" "command -v keepassxc" "sudo apt update && sudo apt install -y keepassxc"
install_software "Bitwarden" "command -v bitwarden" "sudo snap install bitwarden"
install_software "Tor" "command -v tor" "sudo apt update && sudo apt install -y torbrowser-launcher"
install_software "Wireshark" "command -v wireshark" "sudo apt update && sudo apt install -y wireshark"
install_software "Fail2Ban" "command -v fail2ban" "sudo apt update && sudo apt install -y fail2ban && sudo systemctl enable fail2ban && sudo systemctl start fail2ban"
install_software "Logwatch" "command -v logwatch" "sudo apt update && sudo apt install -y logwatch"
install_software "Glances" "command -v glances" "sudo apt update && sudo apt install -y glances"
install_software "Timeshift" "command -v timeshift" "sudo apt update && sudo apt install -y timeshift"
install_software "Cowrie Honeypot" "test -d ~/cowrie" "sudo apt update && sudo apt install -y python3 python3-pip python3-virtualenv git && git clone https://github.com/cowrie/cowrie.git ~/cowrie && cd ~/cowrie && python3 -m venv cowrie-env && source cowrie-env/bin/activate && pip install -r requirements.txt && cp etc/cowrie.cfg.dist etc/cowrie.cfg && echo 'Cowrie honeypot installed. Start with: ~/cowrie/bin/cowrie start'"


# Output the logs
echo "Installations Successful:"
cat $SUCCESS_LOG

echo "Installations Failed:"
cat $FAILURE_LOG
