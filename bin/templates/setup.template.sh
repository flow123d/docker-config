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

addgroup --gid @GROUP_ID@ @USER_NAME@
adduser  --home /home/@USER_NAME@ --shell /bin/bash --uid @USER_ID@ --gid @GROUP_ID@ --disabled-password --system @USER_NAME@


# CUSTOM COMMANDS
# ------------------------------------------------------------------------------

