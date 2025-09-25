# the config folder is copied from the host's git clone so it should already exist

# storage directory should exist for frigate
if [ -d storage ]
then
  echo 'storage directory already exists'
else
  echo 'creating storage directory'
  mkdir storage
fi

# intel gpu tool should be installed
if (dpkg -s intel-gpu-tools > /dev/null)
then
  echo 'intel-gpu-tools is already installed'
else
  # do we want to do checks for other "standard GPU's" ?
  if (lspci | grep -E "VGA|3D" | grep -i intel)
  then
    echo 'installing intel-gpu-tools'
    sudo apt install -y intel-gpu-tools
  else
    echo 'Intel GPU not found.'
  fi
fi

