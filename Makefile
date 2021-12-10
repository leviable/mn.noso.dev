WORKDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

APP := mn.noso.dev

PUBLIC_KEY := $(PUBLIC_KEY)

NOSO_VERSION :=

.PHONY: build
build:
	docker build -t $(APP):latest .

.PHONY: run
run:
	docker run --rm \
		--name $(APP) \
		-v $(WORKDIR)/NOSODATA:/app/NOSODATA \
		$(APP):latest

.PHONY: stop
stop:
	docker stop $(APP)

.PHONY: shell
shell:
	docker run --rm -it --entrypoint bash $(APP):latest

.PHONY: exec
exec:
	docker exec -it $(APP) bash
