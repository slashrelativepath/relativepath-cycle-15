# frigate 
to run frigate: 
```shell
docker compose up -d
```

to get frigate password and URL:
```shell
echo "Your password is: $(sudo docker logs frigate | grep -i 'password:' | awk '{print $10}') and your frigate URL is at: https://$(hostname -I | awk '{print $1}'):8971"
```
