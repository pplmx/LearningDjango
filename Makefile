.PHONY: image start restart k dev prod export clean help
.DEFAULT_GOAL := help

IMAGE_NAME="pplmx/drf_sample"
COMPOSE_SERVICE_NAME="sample"
K8S_APP="k8s/app.yml"

# Init the venv
init: sync
	@uvx pre-commit install --hook-type commit-msg --hook-type pre-push

# Sync the project with the venv
sync:
	@uv sync

# Ruff
ruff:
	@uvx ruff format .
	@uvx ruff check . --fix

# Build image
image:
	@docker image build -t ${IMAGE_NAME} .

# Start services
start:
	@docker compose -p ${COMPOSE_SERVICE_NAME} up -d

# Stop services
stop:
	@docker compose -p ${COMPOSE_SERVICE_NAME} down

# Restart services
restart: stop start

# Deploy to k8s
k:
	@kubectl apply -f ${K8S_APP}

# Run dev server
dev: image restart

# Run prod server
prod: image k

# Clean up
clean:
	@docker compose -p ${COMPOSE_SERVICE_NAME} down
	@kubectl delete -f ${K8S_APP} 2> /dev/null || echo "No k8s resource found"
	@docker container prune -f
	@docker image rm -f ${IMAGE_NAME}
	@docker image prune -f

# Show help
help:
	@echo ""
	@echo "Usage:"
	@echo "    make [target]"
	@echo ""
	@echo "Targets:"
	@awk '/^[a-zA-Z\-_0-9]+:/ \
	{ \
		helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} { lastLine = $$0 }' $(MAKEFILE_LIST)
