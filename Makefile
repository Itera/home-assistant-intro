.PHONY: all docker start restart stop delete

all: install start

install: ; docker run --init -d --name="home-assistant" -e "TZ=Norway/Oslo" -v $$PWD/config\:/config --net=host homeassistant/home-assistant\:stable

start: ; docker start home-assistant

restart: ; docker restart home-assistant

stop: ; docker stop home-assistant

delete: stop ; docker rm home-assistant && docker images -a | grep "homeassistant" | awk '{print $$3}' | xargs docker rmi 

soft-delete: stop ; docker rm home-assistant 
