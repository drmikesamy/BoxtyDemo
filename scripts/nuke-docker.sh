docker ps -qa | xargs -r docker stop
docker ps -qa | xargs -r docker rm
docker images -qa | xargs -r docker rmi -f
docker volume ls -q | xargs -r docker volume rm
docker network ls -q | grep -v '^bridge$\|^host$\|^none$' | xargs -r docker network rm

# docker ps -a
# docker images -a 
# docker volume ls
# docker network ls