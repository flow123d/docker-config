# Script documenting server creation, start and stop
# can only be executed within its directory with docker-compose and other configuration files
# It uses docker compose V2 that works as a plugin to docker, providing the "compose" command.
#
# Usage:
# setup.sh setup admin-password
#          start
#          stop



script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"

# function instal_docker_compose {
#     DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
#     mkdir -p $DOCKER_CONFIG/cli-plugins
#     curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
# }

function setup_server {
#     if ! docker compose --help >/dev/null;
#     then install_docker_compose
#     fi
      

    docker compose rm --stop --force --volumes 
    docker volume rm jenkins-ciflow
    
    docker volume create jenkins-ciflow
    docker pull jenkins/jenkins
    docker compose build
    docker compose up       # initial service start
}


export CASC_JENKINS_CONFIG="${script_path}"
cmd=$1
if [ "$cmd" == "setup" ]
then
    read -p "Setup of the Jenkins server will overwrite all previous configurations. Do you want to proceed? [Yy]" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        password=$2
        setup_server 
    fi
elif [ "$cmd" == "start" ]
then
    docker compose up
elif [ "$cmd" == "stop" ]
then
    docker compose stop
fi
