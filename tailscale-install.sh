# Tailscale install script.  Ment to be run from within the VM

TS_URL='https://pkgs.tailscale.com/stable/ubuntu'
TS_KEY='/usr/share/keyrings/tailscale-archive-keyring.gpg'
TS_LIST='/etc/apt/sources.list.d/tailscale.list'

if [ -f $TS_KEY ]
then
  echo 'gpg key exists'
else
  echo 'adding gpg key'
  curl -fsSL "$TS_URL/noble.noarmor.gpg" -o $TS_KEY
fi

# Note: the following <(inline file) notation is bash specific and won't work in sh
if (diff <(curl -fsSL "$TS_URL/noble.tailscale-keyring.list") $TS_LIST > /dev/null) 
then
  echo 'tailscale source already added to apt'
else
  echo 'adding tailscale source to apt'
  curl -fsSL "$TS_URL/noble.tailscale-keyring.list" -o $TS_LIST
fi

if (apt-cache show tailscale > /dev/null)
then
  echo 'tailscale already in apt-cache'
else
  echo 'updating apt-cache'
  sudo apt update
fi

if (tailscale --version > /dev/null)
then
  echo 'tailscale already installed'
else
  echo 'installing tailscale'
  sudo apt install -y tailscale
fi

