docker pull portainer/portainer-ce:latest

current_image_id=$(docker inspect --format='{{.Image}}' portainer)
latest_image_id=$(docker inspect --format='{{.Id}}' portainer/portainer-ce:latest)

if [ "$current_image_id" != "$latest_image_id" ]; then
  echo "Update available, updating Portainer..."

  docker stop portainer
  docker rm portainer
  docker run -d \
    -p 9000:9000 \
    -p 9443:9443 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    --name portainer \
    --restart always \
    portainer/portainer-ce:latest

  echo "Update successful!"
else
  echo "No update available..."
fi

