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
