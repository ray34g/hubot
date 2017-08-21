FROM node
MAINTAINER ray34g

RUN npm install -g yo generator-hubot
RUN npm list -g yo generator-hubot

ARG install_dir="/usr/share/hubot"
ARG adapter="mattermost"

RUN useradd -d ${install_dir} -m -s /bin/bash -U hubot
RUN mkdir -p ${install_dir} && chown hubot:hubot ${install_dir}

USER hubot
WORKDIR ${install_dir}
RUN  yo hubot --owner "ray34g" --name "ray34g-bot" --description "ray34g-lab bot" --adapter ${adapter}
RUN rm -rf hubot-scripts.json && sed -i "/hubot-heroku-keepalive/d" external-scripts.json

RUN npm install lodash cron 

# CMD cd ${install_dir}; bin/hubot --adapter ${adapter}
