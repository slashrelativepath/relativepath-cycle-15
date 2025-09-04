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



