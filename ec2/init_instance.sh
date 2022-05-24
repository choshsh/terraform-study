#! /bin/bash
sudo -u ec2-user -i <<'EOF'
set -ex

NODE_VERSION=16.13

# install nodejs, package
function setup_nodejs {
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
  source ~/.bashrc
  nvm install $NODE_VERSION
}

function setup_pm2 { 
  npm install pm2 -g
  pm2 install pm2-graceful-intercom
  pm2 install pm2-logrotate
}

function main {
  sudo yum update -y
  setup_nodejs
  setup_pm2
}

main

exit 0
EOF