#!/bin/bash
# author: Jan Hybs
# 
# this is template file for following docker images
#  - flow-libs-dev-dbg
#  - flow-libs-dev-rel
#  
# purpose of this file is to create more easy to use
# environment in docker images


# CREATE USER AND GROUP
# ------------------------------------------------------------------------------
echo 'group: @USER_NAME@(@GROUP_ID@)'
echo 'user:  @USER_NAME@(@USER_ID@)'

addgroup --gid @GROUP_ID@ --force-badname @USER_NAME@
adduser  --home /home/@USER_NAME@ --shell /bin/bash --uid @USER_ID@ --gid @GROUP_ID@ --disabled-password --system --force-badname @USER_NAME@

# echo -e "\n . /etc/profile.d/autoload.sh\n" >> ~/.profile

# BUILDER COMMANDS
# ------------------------------------------------------------------------------
# create folder where user will have access to
mkdir -p /opt/flow123d/flow123d
chown -R @USER_NAME@ /opt/flow123d/

ls -la /opt
ls -la /opt/flow123d
ls -la /opt/flow123d/flow123d

IMAGE_TAG="@IMAGE_TAG@"
if [[ -n "${IMAGE_TAG}" ]]; then
    # echo -e "\nexport PS1=\"\u@${IMAGE_TAG}:\w\$ \"\n" >> /etc/profile.d/autoload.sh
    echo -e "\nexport PS1=\"\[\033[01;32m\]\u@${IMAGE_TAG}\[\033[01;36m\] \w \$ \[\033[00m\]\"\n" >> /etc/profile.d/autoload.sh
fi

cat >> /etc/profile.d/autoload.sh  << EOL
# shortcuts
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

EOL
