VM_NAME='relativepath'

if (test "$(multipass info $VM_NAME | grep 'Name:' | awk '{print $2}')" = "$VM_NAME")
then
  echo "VM $VM_NAME already exists."
else
  echo "creating VM $VM_NAME."
  multipass launch --name $VM_NAME --cpus 4 --memory 4G --disk 50G
fi

echo "Updating the VM..."
multipass exec $VM_NAME -- bash -c 'sudo apt update && sudo apt upgrade -y'

if (multipass exec $VM_NAME -- test -f tailscale-install.sh)
then
  echo "Tailscale install script already exists."
else
  echo "Copying tailscale install script to $VM_NAME VM."
  multipass transfer tailscale-install.sh $VM_NAME:
fi

if (multipass exec $VM_NAME -- test -d frigate)
then
  echo "Frigate folder already exists."
else
  echo "Copying frigate folder to $VM_NAME VM."
  multipass transfer -r frigate $VM_NAME:
fi

echo "Installing docker..."
multipass exec relativepath -- bash frigate/docker.sh

echo "Installing frigate dependencies..."
multipass exec relativepath -- bash frigate/frigate.sh

# give us a fresh VM state after all the installs (docker *cough*)
echo "Restarting the VM..."
multipass restart $VM_NAME

echo
echo
echo 'Next steps: log in and `docker compose up -d` from ~/frigate'
echo "multipass shell $VM_NAME"
echo

