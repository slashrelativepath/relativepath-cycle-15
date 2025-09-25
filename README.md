# Relative Path Cycle 15

## Starting fresh
To wipe a previous VM, or to ensure a clean start, run the following:
```shell
$SHELL delete-vm.sh
```

## VM Creation
create vm script will transfer tailscale script an frigate folder
```shell
$SHELL create-vm.sh
```

## Inside the vm
Drop into a shell inside the VM using the following command:
```shell
multipass shell relativepath
````
Next we'll install docker and frigate, which we have scripts for.

This will install docker and docker-compose
```shell
$SHELL frigate/docker.sh
```

And then ensure all of the dependencies are installed so frigate can be launched via docker.
```shell
$SHELL frigate/frigate.sh
```

