sudo apt install golang -y
go version

version_latest=$(curl -s https://api.github.com/repos/thazelart/terraform-validator/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
wget "https://github.com/thazelart/terraform-validator/releases/download/${version_latest}/terraform-validator_Linux_x86_64.tar.gz"
tar -zxvf terraform-validator_Linux_x86_64.tar.gz
chmod +x terraform-validator
sudo mv terraform-validator /usr/local/bin

terraform-validator --version
