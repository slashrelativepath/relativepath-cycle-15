if (gpg /usr/share/keyrings/tailscale-archive-keyring.gpg)
then
  echo 'gpg key exists'
else
  echo 'adding gpg key'
  curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
fi

if (diff <(curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list) /etc/apt/sources.list.d/tailscale.list) 
then
  echo 'tailscale source already added to apt'
else
  echo 'adding tailscale source to apt'
  curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
fi

if (apt-cache show tailscale)
then
  echo 'tailscale already in apt-cache'
else
  echo 'updating apt-cache'
  sudo apt update
fi

if (tailscale --version)
then
  echo 'tailscale already installed'
else
  echo 'installing tailscale'
  sudo apt install -y tailscale
fi

