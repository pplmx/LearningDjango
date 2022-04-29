IMAGE_NAME="pplmx/djgo"
COMPOSE_SERVICE_NAME="sample"

image:
	docker image build -t ${IMAGE_NAME} .

start:
	docker compose -p ${COMPOSE_SERVICE_NAME} up -d

restart:
	docker compose -p ${COMPOSE_SERVICE_NAME} down
	docker compose -p ${COMPOSE_SERVICE_NAME} up -d

dev: image restart
