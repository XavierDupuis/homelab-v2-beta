# /bin/bash

# Ensure sudo is installed without using sudo
if ! command -v sudo &> /dev/null; then
    echo "sudo is not installed. Installing..."
    apt update && apt install -y sudo
else
    echo "sudo is already installed."
fi

# Update package list and install prerequisites
echo "Installing prerequisites..."
sudo apt update && sudo apt install -y git curl unzip lsb-release

# Install Ansible
if ! command -v ansible &> /dev/null; then
    echo "Installing Ansible..."
    export LC_ALL=C.UTF-8
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
else
    echo "Ansible is already installed."
fi

# Install Terraform
if ! command -v terraform &> /dev/null; then
    echo "Installing Terraform..."
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt install -y terraform
else
    echo "Terraform is already installed."
fi

# Clone the homelab repository
if [ ! -d "$HOME/homelab-v2-beta" ]; then
    echo "Cloning homelab-v2-beta repository..."
    cd $HOME
    git clone https://github.com/XavierDupuis/homelab-v2-beta.git
else
    echo "homelab-v2-beta repository already exists."
fi