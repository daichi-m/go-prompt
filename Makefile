.DEFAULT_GOAL := all
SOURCES := $(shell find . -prune -o -name "*.$(GOBIN)" -not -name '*_test.$(GOBIN)' -print)

GO111MODULE ?= on
GOBIN ?= go


.PHONY setup
setup:
	$(GOBIN) install $(GOBIN)lang.org/x/tools/cmd/$(GOBIN)imports
	$(GOBIN) get -u

.PHONY fmt
fmt: $(SOURCES)
	$(GOBIN)imports -w $^

.PHONY tests
tests: 
	$(GOBIN) test -race -covermode atomic -coverprofile coverage.txt .

.PHONY build
build:
	$(GOBIN) build .

.PHONY all
all: setup fmt tests build