#!/bin/bash

USER=${USER:-user}
USER_ID=${USER_ID:-9001}
GROUP_ID=${GROUP_ID:-9001}

echo "${USER}:x:${USER_ID}:${GROUP_ID}:Default User,,,:/home/${USER}:/bin/bash" >> /etc/passwd
echo "${USER}:x:${GROUP_ID}:" >> /etc/group
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER}
chmod 0440 /etc/sudoers.d/${USER}
usermod -a -G users ${USER}

# Execute the real command
exec /usr/local/bin/gosu ${USER} "$@"

