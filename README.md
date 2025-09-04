# Relative Path Cycle 15


## tailscale
create vm and install tailscale, transfer script and ssh 
`$SHELL create-vm.sh && multipass transfer tailscale-install.sh relativepath: && multipass shell relativepath`

delete vm
`$SHELL delete-vm.sh`

## frigate
``` shell
$SHELL create-vm.sh && multipass transfer -r frigate relativepath: && multipass shell relativepath
```

