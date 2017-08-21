# Hubot Container

```
docker build -t hubot .
```
```
docker run --rm -it \
-v /etc/localtime:/etc/localtime:ro \
-v ~/hubot/scripts:/usr/share/hubot/scripts \
-p 9999:9999 \
-e PORT=9999 \
-e MATTERMOST_ENDPOINT="/hubot/incoming" \
-e MATTERMOST_INCOME_URL="http://192.168.22.101:8065/hooks/3aabe86ubp87uj54tbffkgf3zo" \
-e MATTERMOST_TOKEN="ohxpjt1mc7gqfdf11wfbhfnwjy" \
-e MATTERMOST_ICON_URL="" \
-e MATTERMOST_HUBOT_USERNAME="ray34g-bot" \
--name "hubot" hubot bin/hubot --adapter mattermost
```
