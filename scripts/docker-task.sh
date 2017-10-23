imageName="vscode-docker-debug"
containerName="${imageName}"
workdir="src/api"

# Kills all containers based on the image
killContainers () {
  echo "Killing all containers based on the ${imageName} image"
  docker rm --force $(docker ps -q -a --filter "name=${imageName}")
}

# Composes a new container
composeContainer () {
  docker-compose stop
  docker-compose rm
  docker-compose up -d
}

# Shows the usage for the script.
showUsage () {
  echo "Usage: dockerTask.sh [COMMAND]"
  echo "    Runs command"
  echo ""
  echo "Commands:"
  echo "    cleanup: Removes the image '$imageName' and kills all containers based on this image."
  echo "    compose: Builds the debug image and runs docker compose up."
  echo ""
  echo "Example:"
  echo "    ./docker-task.sh compose"
  echo ""
  echo "    This will:"
  echo "        Build a Docker image named $imageName using debug environment and start a new Docker compose container."
}

# Run
if [ $# -eq 0 ]; then
  showUsage
else
  case "$1" in
    "cleanup")
            killContainers
            removeImage
            ;;
    "compose")
            killContainers;
            composeContainer
            ;;
    *)
            showUsage
            ;;
  esac
fi