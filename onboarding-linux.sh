# nano should be installed
if (which nano)
then
  echo 'nano is already installed' 
else
  echo 'installing nano'
  sudo apt install -y nano
fi

# git should be installed
if (git --version)
then
  echo 'git is already installed'
else
  echo 'installing git'
  sudo apt install -y git
fi

# an ssh key-pair should exist
if (stat $HOME/.ssh/relativepath)
then
  echo 'key pair already exists'
else
  echo 'generating relative path key-pair'
  ssh-keygen -t ed25519 -f $HOME/.ssh/relativepath -N ''
fi

# snap should be installed
if (snap --version)
then
  echo "Snap is already installed"
else
  echo "Installing snap"
  sudo apt install -y snapd
fi

# multipass should be installed
if (multipass version)
then
  echo 'multipass is installed.'
else
  echo 'installing multipass...'
  sudo snap install multipass
fi
