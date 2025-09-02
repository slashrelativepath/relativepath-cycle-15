# frigate 
to run frigate: 
```shell
docker compose up -d
```

to get frigate password:
```shell
sudo docker ps
sudo docker logs 896a36a18efa
```
use the sha from the frigate running container

find the password in the log
