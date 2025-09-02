#Docker key should be downloaded. 
if (stat /etc/apt/keyrings/docker.asc)
then
  echo "docker key already present"
else
  echo "adding docker key"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc
fi

# docker should be added to the apt sources
if (stat /etc/apt/sources.list.d/docker.list)
then
  echo "Docker already in apt sources."
else
  echo "Adding docker to the apt sources..."
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list  
fi

# docker-ce-cli should be in the apt cache
if (apt-cache show docker-ce-cli)
then
  echo "Apt cache has docker-ce-cli."
else
  echo "Updating apt cache..."
  sudo apt update
fi

# docker-ce-cli should be installed
if (docker --version)
then
  echo "docker-ce-cli is already installed."
else
  echo "Installing docker-ce-cli..."
  sudo apt install -y docker-ce-cli
fi

# containerd.io should be in the apt cache
if (apt-cache show containerd.io)
then
  echo "Apt cache has containerd.io."
else
  echo "Updating apt cache..."
  sudo apt update
fi

# containerd.io should be installed
if (dpkg -s containerd.io)
then
  echo "containerd.io is already installed."
else
  echo "Installing containerd.io..."
  sudo apt install -y containerd.io
fi

# docker-ce should be in the apt cache
if (apt-cache show docker-ce)
then
  echo "Apt cache has docker-ce."
else
  echo "Updating apt cache..."
  sudo apt update
fi

# docker-ce should be installed
if (dpkg -s docker-ce)
then
  echo "docker-ce is already installed."
else
  echo "Installing docker-ce..."
  sudo apt install -y docker-ce
fi

# docker-buildx-plugin should be in the apt cache
if (apt-cache show docker-buildx-plugin)
then
  echo "Apt cache has docker-buildx-plugin"
else
  echo "Updating apt cache..."
  sudo apt update
fi

# docker-buildx-plugin should be installed
if (dpkg -s docker-buildx-plugin)
then
  echo "docker-buildx-plugin is already installed."
else
  echo "Installing docker-buildx-plugin..."
  sudo apt install -y docker-buildx-plugin
fi

# docker-compose-plugin should be in the apt cache
if (apt cache show docker-compose-plugin)
then
  echo "Apt cache has docker-compose-plugin."
else
  echo "Updating apt cache..."
  sudo apt update
fi

# docker-compose-plugin should be installed
if (dpkg -s docker-compose-plugin)
then
  echo "docker-compose-plugin is already installed."
else
  echo "Installing docker-compose-plugin..."
  sudo apt install -y docker-compose-plugin
fi
