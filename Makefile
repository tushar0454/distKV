# `make check` runs exactly what CI runs. Run it before every commit.

VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
LDFLAGS := -ldflags "-X main.version=$(VERSION)"

.DEFAULT_GOAL := help
.PHONY: help build run test fmt fmt-check vet check clean

help: ## show this help
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

build: ## build binaries into ./bin
	go build $(LDFLAGS) -o bin/ ./cmd/...

run: build ## build and run a node
	./bin/distkv

test: ## run all tests with the race detector
	go test -race -count=1 ./...

fmt: ## format all Go files
	gofmt -w .

fmt-check: ## fail if any file is not gofmt'd
	@out=$$(gofmt -l .); if [ -n "$$out" ]; then echo "needs gofmt:"; echo "$$out"; exit 1; fi

vet: ## run go vet
	go vet ./...

check: fmt-check vet test build ## everything CI runs

clean: ## remove build output and local data
	rm -rf bin data
