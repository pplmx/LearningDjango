IMAGE_NAME="pplmx/drf_sample"
COMPOSE_SERVICE_NAME="sample"

image:
	docker image build -t ${IMAGE_NAME} .

start:
	docker compose -p ${COMPOSE_SERVICE_NAME} up -d

restart:
	docker compose -p ${COMPOSE_SERVICE_NAME} down
	docker compose -p ${COMPOSE_SERVICE_NAME} up -d

k8s:
	kubectl apply -f k8s/app.yml

dev: image restart

prod: image k8s

clean:
	docker compose -p ${COMPOSE_SERVICE_NAME} down
	kubectl delete -f k8s/app.yml 2> /dev/null || echo "No k8s resource found"
	docker container prune -f
	docker image rm -f ${IMAGE_NAME}
	docker image prune -f
