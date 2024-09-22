# force-code

```bash
docker run \
    --interactive \
    --tty \
    --pull="missing" \
    --name "force-code" \
    --network host \
    --volume "${PWD}:/work_dir" \
    --volume "/var/run/docker.sock:/var/run/docker.sock" \
     ghcr.io/szakacsadam/force-code:latest \
     /bin/bash
```

```bash
docker ps --filter "name=force-code" --filter "status=running" | grep -q force-code \
|| docker start force-code \
&& docker exec -it force-code /bin/bash
```