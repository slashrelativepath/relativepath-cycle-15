# frigate 
to run frigate: 
```shell
docker compose up -d
```

to get frigate password and URL:
```shell
echo "Your password is: $(sudo docker logs frigate | grep -i 'password:' | awk '{print $10}') and your frigate URL is at: https://$(hostname -I | awk '{print $1}'):8971"
```
 
example networking for dual nic:
```yaml
network:
  version: 2
  ethernets:
    enp1s0f0:
      dhcp4: true
    enp1s0f1:
      addresses:
        - 192.168.1.2/24
      routes:
        - to: default
          via: 192.168.1.1
```
