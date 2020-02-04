FROM php:7.3-cli-alpine

LABEL "repository" = "https://github.com/Accelys/action-robo"
LABEL "homepage" = "https://github.com/Accelys/action-robo"

LABEL "com.github.actions.name"="Action - Robo"
LABEL "com.github.actions.description"="Use Robo task runner with your github action workflow."
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="yellow"

ENV ROBO_VERSION=1.4.11

RUN apk update --no-cache \
  && apk add --no-cache \
  bash \
  openssh-client \
  rsync

# Change default shell to bash (needed for conveniently adding an ssh key)
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN curl -L https://github.com/consolidation/Robo/releases/download/$ROBO_VERSION/robo.phar > /usr/local/bin/robo \
  && chmod +x /usr/local/bin/robo

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
