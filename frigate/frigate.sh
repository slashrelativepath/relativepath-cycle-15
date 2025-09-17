# config directory should exist for frigate
if (stat config)
then
  echo 'config directory already exists'
else
  echo 'creating config directory'
  mkdir config
fi


# storage directory should exist for frigate
if (stat storage)
then
  echo 'storage directory already exists'
else
  echo 'creating storage directory'
  mkdir storage
fi

# intel gpu tool should be installed
if (dpkg -s intel-gpu-tools)
then 
  echo 'intel-gpu-tools is already installed'
else
  echo 'installing intel-gpu-tools'
  sudo apt install -y intel-gpu-tools
fi

